#!/usr/bin/env python3

import argparse
import tkinter
import zipfile

class AddonBuilder:
	'''
	'''
	# subclasses
	class project:
		pass
	# initialization
	def __init__(self):
		# get command line arguments
		self.parser = argparse.ArgumentParser(description="Backs PBOs")
		self.parser.add_argument("project", help="Name of the project to pack.")
		self.parser.add_argument("version", nargs="?", default="dev", help="Version of the project to pack.")
		self.parser.add_argument("-s","--settings", action="store_true", help="If this flag is present, the configurations for the project are opened.")
		self.parser.add_argument("-d","--discord", action="store_true", help="If this flag is present, the project is posted on discord as a zip.")
		self.parser.add_argument("-r","--release", action="store_true", help="If this flag is present, the project is released on GitHub.")
		self.args = self.parser.parse_args()
		self.project.name = self.args.project
		self.project.version = self.args.version
		# open settings if -s flag is present
		if self.args.settings:
			self.settings()
		else:
			# load settings
			self.load()
			self.pack()
	# methods
	def settings(self):
		'''
		Opens the settings interface for the project
		'''
		print("Open settings of", self.project.name)
	def load(self):
		'''
		Loads settings of the project
		'''
	def pack(self):
		'''
		Packs the project
		'''
		print("Packing", self.project.name, self.project.version)
	def postOnDiscord(self, channel, message):
		'''
		Posts the project as a zip-file on Discord
		'''
		pass
	def release(self):
		'''
		Releases the project on GitHub
		'''
		pass


if __name__ == "__main__":
	AddonBuilder()
