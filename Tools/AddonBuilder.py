#!/usr/bin/env python3

import argparse, configparser
import sys, os, shutil, subprocess
import zipfile, tempfile

class AddonBuilder:
	'''
	An instance of this class packs an ArmA add-on and releases it if needed.
	The behavior depends on the passed command line arguments.
	Was tested in CMD, Cygwin and Git-Sdk.
	'''
	# subclasses
	
	class Project:
		'''
		Class for the current project
		'''
		def __init__(self, name="", version=""):
			self.name = name
			self.version = version
	
	class Procs:
		'''
		Class for the running subprocesses
		'''
		def __init__(self, procList=[]):
			self.list = procList
			self.outputs = []
		def __enter__(self):
			return self
		def __exit__(self, *args):
			del self
		def add(self, proc):
			self.list.append(proc)
		def wait(self):
			for proc in self.list:
				proc.wait()
		def readOutputs(self):
			self.outputs = [proc.stdout.read().decode("UTF-8") for proc in self.list]
		
	class Discord:
		'''
		Class for discord related stuff
		'''
		def post(self, channel, message):
			'''
			Posts the project
			'''
			pass
	class Github:
		'''
		Class for the GitHub related stuff
		'''
		def release(self):
			'''
			Releases the project
			'''
			pass
	class Workshop:
		'''
		Class for the Steam Workshop related related stuff
		'''
		def release(self):
			'''
			Releases the project
			'''
			pass
	class Print:
		'''
		Group of print functions
		'''
		@classmethod
		def _stream(cls, *text, sep=" ", end="\n", col=False, exit=False, pause=False, _colprefix="", _colpostfix="", _stream=sys.stdout):
			line = sep.join(text) + end
			if col and os.name == "posix":
				# use ANSI coloring
				line = _colprefix + line + _colpostfix
			_stream.write(line)
			if exit:
				if pause:
					input("\nPRESS ENTER TO CONTINUE.")
				sys.exit(1)
		@classmethod
		def stdout(cls, *text, **kwargs):
			'''
			stdout(value, ..., sep=" ", end="\n", col=False, exit=False, pause=False)
			
			Prints values to sys.stdout
			Optional keyword arguments:
			sep:	string inserted between values, default a space.
			end:	string appended after the last value, default a newline.
			col:	if True and the OS is kind of posix the text is colored in green (default: False)
			exit:	True: exits script and returns 0 (default: False)
			pause:	if exit and pause are True, then PRESS ENTER TO CONTINUE will appear (default: False)
			'''
			cls._stream(*text, _colprefix="\033[01;32m", _colpostfix="\033[0m", **kwargs)
		@classmethod
		def stderr(cls, *text, **kwargs):
			'''
			stderr(value, ..., sep=" ", end="\n", col=False, exit=False, pause=False)
			
			Prints values to sys.stderr
			Optional keyword arguments:
			sep:	string inserted between values, default a space.
			end:	string appended after the last value, default a newline.
			col:	if True and the OS is kind of posix the text is colored in red (default: False)
			exit:	True: exits script and returns 1 (default: False)
			pause:	if exit and pause are True, then PRESS ENTER TO CONTINUE will appear (default: False)
			'''
			cls._stream(*text, _colprefix="\033[01;31m", _colpostfix="\033[0m", _stream=sys.stderr, **kwargs)
		
	# initialization
	def __init__(self):
		# get paths
		self.cwd = os.getcwd()
		self.pyFilePath = os.path.dirname(os.path.realpath(__file__))
		# create instances of the subclasses
		self.project = self.Project()
		# check for a project folder
		for entry in os.scandir(os.path.join(self.pyFilePath, "..")):
			if entry.is_dir() and entry.name[0] == "@":
				self.project.name = entry.name[1:]
		# get command line arguments
		self.parser = argparse.ArgumentParser(description="Packs PBOs")
		if self.project.name == "":
			# get the project name as an argument if none was found
			self.parser.add_argument("project", help="Name of the project to pack.")
		self.parser.add_argument("version", nargs="?", default="dev", help="(optional) Version of the project to pack. Default is \"dev\".")
		self.parser.add_argument("-c","--configure", action="store_true", help="If this flag is present, the configuration for the project is opened.")
		self.parser.add_argument("-d","--discord", action="store_true", help="If this flag is present, the project is posted on discord as a zip.")
		self.parser.add_argument("-r","--release", action="store_true", help="If this flag is present, the project is released on GitHub.")
		self.args = self.parser.parse_args()
		# set project attributes
		if self.project.name == "":
			self.project.name = self.args.project
		self.project.version = self.args.version
		# config init
		self.config =  configparser.ConfigParser()
		self.config.path = os.path.join(self.pyFilePath, "AddonBuilder.ini")
		# run the builder
		if self.args.configure:
			# open configurations if -c flag is present
			self.configuration()
		else:
			# pack the add-on otherwise
			try:
				# check config
				self.config.read(self.config.path)
				self.config[self.project.name]
			except KeyError:
				# generate a new configuration if it was not found
				self.Print.stderr("Error: You have to configure your project first!", col=True)
				self.configuration()
				self.Print.stdout("AddonBuilder canceled!\n", exit=True, pause=True)
			# load configuration data
			self.load()
			# generate a bikey if needed
			if not os.path.isfile(self.project.biprivatekeyPath):
				self.genBikey()
			# pack the PBOs
			self.pack()
	# methods
	def configuration(self):
		'''
		Opens the configuration file for the project.
		If it does not exists, then a new one is created.
		'''
		# check if a config for the rpject exist
		try:
			self.config.read(self.config.path)
			self.config[self.project.name]
		except KeyError:
			self.Print.stdout("Generating a new configuration...")
			self.steamFolderPath = None
			if os.name == "nt":
				# search for steam folder in windows registry
				import winreg
				try:
					reg = winreg.ConnectRegistry(None, winreg.HKEY_CURRENT_USER)
					entries = winreg.OpenKey(reg, r"Software\Valve\Steam")
					self.steamFolderPath = winreg.QueryValueEx(entries, "SteamPath")[0]
					self.steamFolderPath = self.steamFolderPath.replace("/", os.path.sep)
				except FileNotFoundError:
					pass
			elif os.name == "posix":
				# check if the default path is valid on Linux
				if os.path.isfile("~/.local/share/Steam"):
					self.steamFolderPath = "~/.local/share/Steam"
			if not self.steamFolderPath:
				# if steam folder path was not found, then ask the user
				try:
					while True:
						self.steamFolderPath = input("Enter the path to your Steam folder:\n")
						if os.path.isdir(self.steamFolderPath):
							break
						else:
							self.Print.stderr("Error: Your given path was invalid!", col=True)
							continue
				except KeyboardInterrupt:
					self.Print.stdout("Canceled!", exit=True)
			# generate a provisional config file
			with open(self.config.path, "a") as configStream:
				configStream.write("# Warning: This file was generated automatically!\n")
				configStream.write("# Warning: The folder paths may have to be corrected!\n")
				configStream.write("[{}]\n".format(self.project.name))
				configStream.write("# Path to the ArmA 3 Tools folder\n")
				configStream.write("toolsPath = {}\n".format(os.path.join(self.steamFolderPath, "steamapps", "common", "Arma 3 Tools")))
				configStream.write("# Path to the @{} folder\n".format(self.project.name))
				configStream.write("projectFolderPath = {}\n".format(os.path.join(self.steamFolderPath, "steamapps", "common", "Arma 3", "@" + self.project.name)))
				configStream.write("# The prefix for the PBO paths. The path to the root of the PBO will be pboPrefix\\pboName. A substitute is available: {0} for the project name\n")
				configStream.write("pboPrefixFormatted = {0}\n")
				configStream.write("# Name for the bikey file. Two substitutes are available: {0} for the project name and {1} for the version\n")
				configStream.write("bikeyFormatted = {0}_{1}\n")
				configStream.write("# Path to the bikey folder. A new key is generated if it does not exist in there.\n")
				configStream.write("bikeyFolderPath = {}\n".format(os.path.join(self.steamFolderPath, "steamapps", "common", "Arma 3", "@" + self.project.name, "keys")))
				configStream.write("# Path to the biprivatekey folder. A new key is generated if it does not exist in there.\n")
				configStream.write("biprivatekeyFolderPath = {}\n".format(os.path.join(self.steamFolderPath, "steamapps", "common", "Arma 3 Tools", "DSSignFile", "privateKeys")))
		# open the config file
		self.Print.stdout("Open configurations of", self.project.name)
		if sys.platform.startswith("darwin"):
			subprocess.call(["open", self.config.path])
		elif os.name == "nt":
			os.startfile(self.config.path)
		elif sys.platform.startswith("Linux"):
			subprocess.call(["xdg-open", self.config.path])
		elif sys.platform.startswith("msys") or sys.platform.startswith("cygwin"):
			subprocess.call(["cygstart", self.config.path])
	
	def load(self):
		'''
		Loads configurations of the project.
		Switches to the configuration method if there is no configuration for the project.
		'''
		# read from config
		self.toolsPath = self.config[self.project.name]["toolsPath"]
		self.exePath = os.path.join(self.toolsPath, "AddonBuilder", "AddonBuilder.exe")
		self.DSCreateKeyPath = os.path.join(self.toolsPath, "DSSignFile", "DSCreateKey.exe")
		self.project.folderPath = self.config[self.project.name]["projectFolderPath"]
		self.project.pboFolderPath = os.path.join(self.project.folderPath, "addons")
		self.project.pboPrefixFormatted = self.config[self.project.name]["pboPrefixFormatted"]
		self.project.pboPrefix = self.project.pboPrefixFormatted.format(self.project.name)
		self.project.bikeyFormatted = self.config[self.project.name]["bikeyFormatted"]
		self.project.bikeyName = self.project.bikeyFormatted.format(self.project.name, self.project.version)
		self.project.bikeyFolderPath = self.config[self.project.name]["bikeyFolderPath"]
		self.project.bikeyPath = os.path.join(self.project.bikeyFolderPath, self.project.bikeyName + ".bikey")
		self.project.biprivatekeyFolderPath = self.config[self.project.name]["biprivatekeyFolderPath"]
		self.project.biprivatekeyPath = os.path.join(self.project.biprivatekeyFolderPath, self.project.bikeyName + ".biprivatekey")
		# check if folder paths are valid
		for path in [self.project.folderPath, self.project.bikeyFolderPath, self.project.biprivatekeyFolderPath]:
			if not os.path.isdir(path):
				self.Print.stderr("Error: {} does not exist!".format(path), col=True, exit=True, pause=True)
		# check if file paths are valid
		for path in [self.exePath, self.DSCreateKeyPath]:
			if not os.path.isfile(path):
				self.Print.stderr("Error: {} does not exist!".format(path), col=True, exit=True, pause=True)
	
	def pack(self):
		'''
		Generates the PBOs for the project.
		'''
		# pack folders
		self.Print.stdout("Build {} {}:".format(self.project.name, self.project.version))
		# create instance of procs subclass
		with self.Procs() as self.procs: 
			for entry in os.scandir(self.project.pboFolderPath):
				if entry.is_dir():
					self.Print.stdout("Packing", entry.name, "...")
					proc = subprocess.Popen('"{}" "{}" "{}" -sign="{}" -prefix="{}\\{}" "-packonly" "-binarizeFullLogs"'.format(self.exePath, entry.path, self.project.pboFolderPath, self.project.biprivatekeyPath, self.project.pboPrefix, entry.name), shell=True, stderr=subprocess.STDOUT, stdout=subprocess.PIPE)
					self.procs.add(proc)
			# wait for all subprocs
			self.procs.wait()
			# print error messages
			self.procs.readOutputs()
			errorCounter = 0
			for output in self.procs.outputs:
				for line in output.split("\n"):
					messageType = line[27:32]
					if messageType == "ERROR":
						self.Print.stderr(line, col=True)
						errorCounter += 1
					elif messageType == "FATAL":
						self.Print.stderr(line, col=True, exit=True, pause=True)
			if errorCounter == 0:
				self.Print.stdout("Packing completed!", col=True)
			else:
				self.Print.stdout("Exiting with {} errors!".format(errorCounter), exit=True, pause=True)
	def genBikey(self):
		'''
		Creates a bikey+biprivatekey and moves them to the target folders
		'''
		if not os.path.isfile(self.project.biprivatekeyPath):
			self.Print.stdout("Generating", self.project.bikeyName + ".bikey", "...")
			os.chdir(self.project.biprivatekeyFolderPath)
			subprocess.check_call([self.DSCreateKeyPath, self.project.bikeyName])
			shutil.move(os.path.join(self.project.biprivatekeyFolderPath, self.project.bikeyName + ".bikey"), self.project.bikeyPath)
			os.chdir(self.cwd)
			self.Print.stdout("Bikey generated!", col=True)
		
if __name__ == "__main__":
	AddonBuilder()
