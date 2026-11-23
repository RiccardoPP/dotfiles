#!/usr/bin/env python3
#
# Version 3.1.0 (Labwc/Openbox Full Menu + Custom Footer `Optional`)
# Revised: Harsh-bin
# Original Authors: rmoe (v1.1.7) & onuronsekiz (overlord)
#
# / revisions and additions:
#
# - recoded for python 3.9+
# - menu sort for both categories and programs
# - finding all possible icons by searching deeply in themes
# - icon search algorithm for faster approach 
# - desktop item ignored if Exec command not found in system
# - automatic and direct theme selection if possible
# - flatpak applications support
# - duplicate icon handling
# - ADDED: Checks ~/.config/gtk-3.0/settings.ini for icon theme first
# - ADDED: Static file generation with pretty printing for Labwc
# - ADDED: Custom Footer with dynamic icons and separator
# - ADDED: Auto-reconfigure Labwc after static generation
#
# ----- config ---

import subprocess, glob, os, sys, argparse

userhome = os.path.expanduser('~')
applications_dirs = ("/usr/share/applications", userhome + "/.local/share/applications","/var/lib/flatpak/exports/share/applications")
image_dir_base = ("/usr/share", "/var/lib/flatpak/exports/share") # without "pixmaps" -/usr/local/share in FreeBSD, /usr/share on linux

# --- Theme Selection Logic ---
selected_theme = None

# Priority: Check GTK 3.0 settings
try:
	gtk3_config = userhome + "/.config/gtk-3.0/settings.ini"
	if os.path.exists(gtk3_config):
		with open(gtk3_config, 'r') as f:
			for line in f:
				if "gtk-icon-theme-name" in line and "=" in line:
					selected_theme = line.split("=", 1)[1].strip().strip('"').strip("'")
					break
except IOError:
	pass

# Fallback: Check GTK 2.0 config
if selected_theme is None:
	try:
		with open(userhome + "/.gtkrc-2.0", 'r') as readobj:
			for line in readobj:
				if "gtk-icon-theme-name" in line:
					parts = line.split("\"")
					if len(parts) > 1:
						selected_theme = parts[1]
						break
	except IOError:
		pass

# Final Fallback
if selected_theme is None:
	selected_theme = "Adwaita"

application_groups = ("AudioVideo", "Development", "Editors",  "Engineering", "Games", "Graphics", "Internet",  "Multimedia", "Office",  "Other",  "Settings", "System",  "Utilities") # enter here new category as you wish, it will be sorted
group_aliases = {"Audio":"Multimedia","Video":"Multimedia","AudioVideo":"Multimedia","Network":"Internet","Game":"Games", "Utility":"Utilities", "Development":"Editors","GTK":"",  "GNOME":""}
ignoreList = ("gtk3-icon-browser","evince-previewer", "Ted",  "wingide3.2", "python3.4", "feh","xfce4-power-manager-settings", "picom","compton","yad-icon-browser" )
prefixes = ("legacy","categories","apps","devices","mimetypes","places","preferences","actions", "status","emblems") #added for prefered icon dirs and sizes. could be gathered automatically but wouldn't be sorted like this
iconSizes = ("48","32","24","16","48x48","40x40","36x36","32x32","24x24","64x64","72x72","96x96","16x16","128x128","256x256","scalable","apps","symbolic")
terminal_string = "foot"
  
#constants and list for icon list generating
image_file_prefix = (".png", ".svg", ".xpm")
image_cat_prefix = ("applications-", "accessories-dictionary", "accessories-text-editor","preferences-desktop.","audio-speakers") 
iconThemes=os.listdir(image_dir_base[0]+"/icons")
tmplst=[s for s in iconThemes if selected_theme in s]
selected_theme = iconThemes[0] if tmplst == [] else tmplst[0]
iconThemes.sort(key=str.lower)

if selected_theme in iconThemes:
	iconThemes.remove(selected_theme)
iconThemes.remove('hicolor') if 'hicolor' in iconThemes else False
iconThemes.insert(0, selected_theme) if selected_theme != 'hicolor' else False
iconThemes.insert(0, "hicolor")
iconList=[]

#getting icons to lists for faster menu generate
def addIconsToList(List, theme): # skip to next icon theme if any icon couldn't found on current
	for path in reversed(image_dir_base):
		for prfx in prefixes:
			for size in iconSizes:
				tmp = path + "/icons/" + theme + "/" + size + "/" + prfx
				if theme == "breeze" or theme == "breeze-dark":
					tmp = path + "/icons/" + theme + "/" + prfx + "/" + size
				try:
					List.extend(tmp + "/" +  x for x in os.listdir(tmp) if x.lower().endswith(image_file_prefix))
				except IOError:
					continue
	return List

def which(program): #check if program exist
	def is_exe(fpath):
		return os.path.isfile(fpath) and os.access(fpath, os.X_OK)
	fpath, fname = os.path.split(program)
	if fpath:
		if is_exe(program):
			return program
	else:
		for path in os.environ["PATH"].split(os.pathsep):
			exe_file = os.path.join(path, program)
			if is_exe(exe_file):
				return exe_file
	return None

# Helper to find specific icons for the footer
def find_best_icon(possible_names):
	for name in possible_names:
		# Search in our generated iconList
		# look for /name.png or /name.svg
		matches = [s for s in iconList if "/" + name + "." in s or "/" + name + "-" in s]
		if len(matches) > 0:
			matches.sort(key=len)
			return matches[0]
	return ""

class dtItem(object):
	def __init__(self, fName):
		self.fileName = fName
		self.Name = ""
		self.Comment = ""
		self.Exec = ""
		self.Terminal = None
		self.Type = ""
		self.Icon = ""
		self.Categories = ()

	def addName(self, data):
		self.Name = xescape(data)

	def addComment(self, data):
		self.Comment = data

	def addExec(self, data):
		if len(data) > 3 and data[-2] == '%': # get rid of filemanager arguments in dt files
			data = data[:-2].strip()
		self.Exec = data

	def addIcon(self, data):
		self.Icon = ""
		if image_cat_prefix == "":
			return
		image_dir = image_dir_base[0] + "/pixmaps/"
		di = data.strip()
		if len(di) < 3:
			#"Error in %s: Invalid or no icon '%s'" % (self.fileName,  di)
			return
		dix = di.find("/")     # is it a full path? 
		if dix >= 0 and dix <= 2:    # yes, its a path (./path or ../path or /path ...)
			self.Icon = di
			return
		#else a short name like "myapp"
		tmp = glob.glob(image_dir + di + ".*")
		if len(tmp) == 0: #if there is not correct icon in pixmap, check for icon theme
			for theme in iconThemes:
				tmp=[s for s in iconList if di in s] 
				if len(tmp) > 0:
					break # end loop if found
				else:
					addIconsToList(iconList, theme)
		if len(tmp) == 1 and tmp[0] != "/":
			self.Icon = tmp[0]
		if len(tmp) > 1: # if there are duplicated icons take one that has the shortest name
			temp=tmp[0] # assign first item to a temp path
			flen=len(temp.split("/")[-1]) # split filepath with "/" and take last element of list
			for fpath in tmp: # check filepath list for shortest filename
				tlen=len(fpath.split("/")[-1]) # split filepath with / and take last element of list
				if tlen<flen: # replace icon path with shorter filename path
					flen=tlen # reallocate shortest filename length
					temp=fpath # reallocate temp path
			self.Icon = temp
		return

	def addTerminal(self, data):
		if data == "True" or data == "true":
			self.Terminal = True
		else:
			self.Terminal = False

	def addType(self, data):
		self.Type = data

	def addCategories(self, data):
		self.Categories = data

def getCatIcon(cat):
	theme = selected_theme
	cat = image_cat_prefix[0] + cat.lower()
	if theme == "breeze" or theme == "breeze-dark":
		if cat == "applications-editors": cat = "applications-education-language"
		if cat == "applications-settings": cat = "applications-development"
	if theme != "Adwaita" and theme != "gnome":
		if cat == "applications-editors": cat = "applications-development"
	if theme == "Adwaita":
		if cat == "applications-multimedia": cat = "audio-speakers"
	if theme == "Adwaita" or theme == "Papirus" or theme == "gnome":
		if cat == "applications-editors": cat = "accessories-text-editor"
		if cat == "applications-settings": cat = "preferences-desktop"
		if cat == "applications-education": cat = "accessories-dictionary"
	if theme != "breeze" or theme != "breeze-dark":
		if cat == "applications-settings": cat = "preferences-desktop"
	if theme == "Tango":
		if cat == "applications-utilities": cat = "applications-accessories"
	tmp = [s for s in iconList if cat in s]
	if len(tmp) > 0:
		return tmp[0]
	return ""

def xescape(s):
	Rep = {"&":"&amp;", "<":"&lt;", ">":"&gt;",  "'":"&apos;", "\"":"&quot;"}
	for p in ("&", "<", ">",  "'","\""):
		sl = len(s); last = -1
		while last < sl:
			i = s.find(p,  last+1)
			if i < 0:
				done = True
				break
			last = i
			l = s[:i]
			r = s[i+1:]
			s = l + Rep[p] + r
	return s

def process_category(cat, curCats, aliases=group_aliases, appGroups=application_groups):
	# first process aliases
	if aliases.__contains__(cat):
		if aliases[cat] == "":
			return "" # ignore this one
		cat = aliases[cat]
	if cat in appGroups and cat not in curCats: # valid categories only and no doublettes, please
		curCats.append(cat)
		return cat
	return ""

def process_dtfile(dtf,  catDict):  # process this file & extract relevant info
	active = False          # parse only after "[Desktop Entry]" line         
	fh = open(dtf,  "r")
	lines = fh.readlines()
	this = dtItem(dtf)
	for l in lines:
		l = l.strip()
		if l == "[Desktop Entry]":
			active = True
			continue
		if active == False: # we don't care about licenses or other comments
			continue
		if l == None or len(l) < 1 or l[0] == '#':
			continue
		if l[0] == '[' and l !=  "[Desktop Entry]":
			active = False
			continue
		eqi = l.split('=',1)
		if len(eqi) < 2:
			continue
		if eqi[0] == "Name":
			this.addName(eqi[1])
		elif eqi[0] == "Comment":
			this.addComment(eqi[1])
		elif eqi[0] == "Exec":
			eqx=eqi[1].split(" ", 1)[0] 
			if which(eqx) == None: 
				return 
			this.addExec(eqi[1]) 
		elif eqi[0] == "Icon":
			this.addIcon(eqi[1])
		elif eqi[0] == "Terminal":
			this.addTerminal(eqi[1])
		elif eqi[0] == "Type":
			if eqi[1] != "Application":
				continue
			this.addType(eqi[1])
		elif eqi[0] == "Categories":
			if eqi[1] == '':
				eqi[1] = "Other"
			if eqi[1][-1] == ';':
				eqi[1] = eqi[1][0:-1]
			cats = []
			dtCats = eqi[1].split(';')
			for cat in dtCats:
				result = process_category(cat,  cats)
			this.addCategories(cats)
		else:
			continue
	if len(this.Categories) > 0:       
		for cat in this.Categories:
			catDict[cat].append(this)

addIconsToList(iconList, selected_theme) 
categoryDict = {}

def print_custom_footer(handle, is_static):
	# Define custom items: [Label, ActionName, Command, PossibleIcons]
	# Edit this according to you
	footer_items = [
		# {
		# 	"label": "Terminal", 
		# 	"action": "Execute", 
		# 	"cmd": "foot", 
		# 	"icons": ["terminal", "x-terminal-emulator", "org.gnome.Terminal"]
		# },
		# {
		# 	"label": "Reload", 
		# 	"action": "Reconfigure", 
		# 	"cmd": None, 
		# 	"icons": ["system-reboot", "view-refresh", "reload"]
		# },
		{
			"label": "Exit", 
			"action": "Exit", 
			"cmd": None, 
			"icons": ["system-log-out", "gnome-logout"]
		}
	]

	# Print Separator
	if is_static:
		handle.write('        <separator />\n')
	else:
		print("<separator />")

	# Print Items
	for item in footer_items:
		iconPath = find_best_icon(item["icons"])
		
		if is_static:
			handle.write(f'        <item label="{item["label"]}"')
			if iconPath:
				handle.write(f' icon="{iconPath}"')
			handle.write('>\n')
			
			handle.write(f'            <action name="{item["action"]}">\n')
			if item["cmd"]:
				escaped_cmd = xescape(item["cmd"])
				handle.write(f'                <command>{escaped_cmd}</command>\n')
			handle.write('            </action>\n')
			handle.write('        </item>\n')
		else:
			# Pipe menu format
			out = f'<item label="{item["label"]}"'
			if iconPath:
				out += f' icon="{iconPath}"'
			out += f'><action name="{item["action"]}">'
			if item["cmd"]:
				out += f'<command><![CDATA[{item["cmd"]}]]></command>'
			out += '</action></item>'
			print(out)


if __name__ == "__main__":
	parser = argparse.ArgumentParser(
		description="Generate Openbox/Labwc menus.\nTo Edit the footer open the code and edit footer_items according to you",
        formatter_class=argparse.RawTextHelpFormatter
	)
	parser.add_argument("-o", "--output", help="Path to output file for static menu generation.")
	parser.add_argument("-f", "--footer", default="true", help="Show custom footer (true/false). Default: true")
	args = parser.parse_args()

	# Logic to convert string argument to boolean
	show_footer = str(args.footer).lower() in ("true", "1", "yes", "on", "t")

	application_groups=sorted(application_groups, key=str.lower)
	for appGroup in application_groups:
		categoryDict[appGroup] = []
	
	dtFiles=[]
	for appDir in applications_dirs:
		appDir += "/*.desktop"
		dtFiles+=glob.glob(appDir)
	
	for dtf in dtFiles:
		skipFlag = False
		for ifn in ignoreList:
			if dtf.find(ifn) >= 0:
				skipFlag = True
		if skipFlag == False:
			process_dtfile(dtf,  categoryDict)

	output_handle = sys.stdout
	if args.output:
		try:
			output_handle = open(args.output, 'w')
		except IOError as e:
			print(f"Error opening output file: {e}", file=sys.stderr)
			sys.exit(1)
	
	if args.output:
		output_handle.write('<?xml version="1.0" encoding="UTF-8"?>\n')
		output_handle.write('<openbox_menu >\n')
		output_handle.write('    <menu id="root-menu" label="Applications">\n')
	else:
		print ("<openbox_pipe_menu>") # This is enough

	appGroupLen = len(application_groups)
	
	for ag in range(appGroupLen):
		catList = categoryDict[application_groups[ag]]
		if len(catList) < 1:
			continue 
		
		tmpList=[] 
		for app in catList: 
			app.Name= ' '.join([word[0].upper()+word[1:] for word in app.Name.split(' ')]) 
			tmpList.append([app.Name, [app.Icon, app.Terminal, app.Exec]]) 
		catList=sorted(tmpList, key = lambda x: x[0].lower()) 
		
		groupName = application_groups[ag]
		groupIcon = getCatIcon(groupName)
		
		if args.output:
			menu_line = f'        <menu id="{groupName}" label="{groupName}"'
			if groupIcon:
				menu_line += f' icon="{groupIcon}"'
			menu_line += ">"
			output_handle.write(menu_line + "\n")

			for app in catList:
				appName = xescape(app[0])
				appIcon = app[1][0]
				isTerm = app[1][1]
				appExec = app[1][2]
				
				cmdString = appExec
				if isTerm:
					cmdString = f"{terminal_string} {appExec}"
				cmdString = xescape(cmdString)

				item_line = f'            <item label="{appName}"'
				if appIcon:
					item_line += f' icon="{appIcon}"'
				item_line += ">"
				output_handle.write(item_line + "\n")
				output_handle.write('                <action name="Execute">\n')
				output_handle.write(f'                    <command>{cmdString}</command>\n')
				output_handle.write('                </action>\n')
				output_handle.write('            </item>\n')

			output_handle.write(f'        </menu> <!-- {groupName} -->\n')

		else:
			catStr = "<menu id=\"openbox-%s\" label=\"%s\" " % (groupName, groupName)
			if groupIcon != "":
				catStr += "icon=\"%s\"" % groupIcon
			print (catStr + ">")
			for app in catList:
				progStr = "<item "
				progStr += "label=\"%s\" " % app[0] 
				if app[1][0] != "": 
					progStr += "icon=\"%s\" " % app[1][0] 
				progStr += "><action name=\"Execute\"><command><![CDATA["
				if app[1][1] == True:  
					progStr += terminal_string + " "
				progStr += "%s]]></command></action></item>"  % app[1][2] 
				print (progStr)
			print ("</menu>")

	# --- PRINT CUSTOM FOOTER ---
	if show_footer:
		print_custom_footer(output_handle, args.output)

	# WRITE FOOTERS
	if args.output:
		output_handle.write('    </menu>\n')
		output_handle.write('</openbox_menu>\n')
	else:
		print ("</openbox_pipe_menu>") 
		
	if args.output and output_handle != sys.stdout:
		output_handle.close()
		
		# --- AUTO RECONFIGURE LABWC ---
		# Only run this if we generated a static file
		print("Attempting to reconfigure labwc...", file=sys.stderr)
		try:
			subprocess.run(["labwc", "--reconfigure"], check=False)
			print("labwc reconfigured successfully.", file=sys.stderr)
		except FileNotFoundError:
			print("Warning: 'labwc' command not found. Skipping reconfigure.", file=sys.stderr)
		except Exception as e:
			print(f"Error reconfiguring labwc: {e}", file=sys.stderr)
