#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <stdbool.h>
#include <Windows.h>

#define MAX_LINE_LEN 	128
#define MAX_CLASS_LVL 	8

#define N_OBJ_ATTR		4
const char *LIST_OBJ_ATTR[]={"pos", "angle", "disableSim", "type"};

/********************************************************************************
*	Function:		strrmblnk (string remove blanks)
*	Description:	removes  spaces, tabs and newlines
********************************************************************************/
void strrmblnk(char *str);

/********************************************************************************
*	Function:		strrplc (string replace character)
*	Description:	replaces character <oldc> by <newc> in <str>
*					if <newc> == 0, then the gap is removed
********************************************************************************/
int strrplc(char *str, char oldc, char newc);

/********************************************************************************
*	Function:		Achilles_fnc_loadSQE
*	Description:	SQE file loading routine
********************************************************************************/
void Achilles_fnc_loadSQE(char *file_path, char buffer[], size_t buffer_size);

/********************************************************************************
*	Function:		Achilles_fnc_ppLine (postprocess line)
*	Description:	Converts content to SQF syntax
********************************************************************************/
void Achilles_fnc_ppLine(char *inp_line, char *out_line);

int main(void)
{
	int outputSize = 10240;
	char output[outputSize];
	char sqe_path[] = "E:\\Programme\\Games\\Steam\\steamapps\\common\\Arma 3\\AresModAchillesExpansion\\src\\dll\\sqe_importer\\composition.sqe";
	char log_name[] = "loadSqe.log";
	FILE *log_stream;
	
	memset(output, 0, outputSize);
	Achilles_fnc_loadSQE(sqe_path, output, outputSize);
	
	fopen_s(&log_stream, log_name, "w");
	fprintf_s(log_stream, "%s\n", output);
	fclose(log_stream);
	
	return EXIT_SUCCESS;
}


void Achilles_fnc_loadSQE(char *sqe_path, char buffer[], size_t buffer_size)
{
	int i_attr;
	int bracket_lvl = 0;
	int class_lvl = 0;
	int class_bracket_lvls[MAX_CLASS_LVL] = {0};
	bool is_object = false;
	const char *obj_attr;
	char line[MAX_LINE_LEN];
	char pp_line[MAX_LINE_LEN];
	FILE *sqe_stream;
	
	printf_s("%s %s %s %s \n", LIST_OBJ_ATTR[0],LIST_OBJ_ATTR[1],LIST_OBJ_ATTR[2],LIST_OBJ_ATTR[3]);
	
	fopen_s(&sqe_stream, sqe_path, "r");
	while (fgets(line, MAX_LINE_LEN, sqe_stream) != NULL)
	{
		strrmblnk(line);
		
		if(line[0] == '{') // handle changes in bracket level
		{
			// printf_s("{ %d %s\n", class_lvl, line);
			bracket_lvl++;
			
		} else if(line[0] == '}') // handle changes in bracket and class level
		{
			bracket_lvl--;
			if(class_bracket_lvls[class_lvl] > bracket_lvl)
			{
				// printf_s("} class %d %s\n", class_lvl, line);
				if(is_object)
				{
					is_object = false;
				}
				class_lvl--;
			} else
			{
				// printf_s("} %d %s\n", class_lvl, line);
			}
			
		} else if(strncmp(line, "class", 5) == 0) // handle changes in class level
		{
			// printf_s("class %d %s\n", class_lvl, line);
			class_lvl++;
			class_bracket_lvls[class_lvl] = bracket_lvl;
			
		} else if(is_object) // current parent class is an object
		{
			// printf_s("is_object %d %s\n", class_lvl, line);
			for(i_attr=0;i_attr<N_OBJ_ATTR;i_attr++)
			{
				obj_attr = LIST_OBJ_ATTR[i_attr];
				if(strncmp(line, obj_attr, strlen(obj_attr)) == 0)
				{
					Achilles_fnc_ppLine(line, pp_line);
					strncat_s(buffer, buffer_size, pp_line, _TRUNCATE);
				}
			}
		} else if (strncmp(line, "dataType=\"Object\"", 17) == 0) // current class is object
		{
			is_object = true;
		} else if (class_lvl == 0) // highest class level
		{
			if(strncmp(line, "center", 6) == 0)
			{
				Achilles_fnc_ppLine(line, pp_line);
				strncat_s(buffer, buffer_size, pp_line, _TRUNCATE);
			}
		} else
		{
			// printf_s("else %d %s\n", class_lvl, line);
		};
	}
	fclose(sqe_stream);
}

void Achilles_fnc_ppLine(char *inp_line, char *out_line)
{
	char *src = inp_line;
	char *target = out_line;
	
	// -- to do: 	find a way to ensure that the buffer is sufficient large for the shift
	//				(current way is fine, since a newline character is removed)
	target[0] = '_';
	target++;
	
	while(*src != 0)
	{
		if(*src == '[')
		{
			/* remove char */
		} else if(*src == ']')
		{
			/* remove char */
		} else if(*src == '\n')
		{
			/* remove char */
		} else if(*src == '{')
		{
			*target = '[';
			target++;
		} else if(*src == '}')
		{
			*target = ']';
			target++;
		} else
		{
			*target = *src; // copy content
			target++;
		}
		src++;
	}
	*target = 0;
}

void strrmblnk(char *str)
{
	char *src = str;
	char *target = str;
	
	while(*src != 0)
	{
		if(!isspace(*src))
		{
			*target = *src; // copy content
			target++;
		}
		src++;
	}
	*target = '\n';
	target++;
	*target = 0;
}

int strrplc(char *str, char oldc, char newc)
{
	int n = 0;
	char *src = str;
	char *target = str;
	
	while(*src != 0)
	{
		if(*src == oldc)
		{
			if(newc != 0)
			{
				*target = newc;
				target++;
			};
			n++;
		} else
		{
			*target = *src; // copy content
			target++;
		}
		src++;
	}
	*target = 0;
	
	return n;
};
