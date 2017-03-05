#!/usr/bin/env python
#
# Author: helour
# Copyright: 2013-2015 helour
# Based on the cr33dog's script Export Layers as PNG (http://registry.gimp.org/node/18440)
# License: GPL v3+
#
# Version: 0.7
#
# GIMP plugin to export layers as a multiple pages PDF file
#
#
# Note for Windows users:
#
# You need add the ImageMagic directory (which consists the 'convert.exe' executable file)
# to the GIMP environment PATH variable into the file:
# C:\Program Files\GIMP 2\lib\gimp\2.0\environ\default.env
#
# like in the example here:
# PATH=${gimp_installation_dir}\bin;${gimp_installation_dir}\32\bin;C:\Program Files\ImageMagick-6.9.1-Q16
# PYTHONPATH=${gimp_installation_dir}\32\lib\gimp\2.0\python


import os
import gtk
from subprocess import check_call
from tempfile import mkstemp

from gimpfu import *

def mktmpfile(suffix):
        fd, filename = mkstemp(suffix=suffix)
        fptr = os.fdopen(fd)
        return filename

def get_layers_to_export(layers, only_visible, gimp_version):
        result = []
        for layer in layers:
                if gimp_version >= 2.8 and pdb.gimp_item_is_group(layer):
                        result += get_layers_to_export(layer.children, only_visible, gimp_version)
                else:
                        if only_visible:
                                if layer.visible:
                                        result.append(layer)
                        else:
                                result.append(layer)
        return result

def combine_images_into_pdf(img_files, pdf_file):
        try:    # Run on shell because of conflict with windows system command 'convert.exe'
                check_call(['/usr/local/bin/convert'] + img_files + [pdf_file], shell = True if os.name == 'nt' else False)
        except Exception as e:
                pdb.gimp_message("Error while executing 'convert' command:\n" +
                                 str(e) +
                                 "\n\nHave you installed the ImageMagic package\nand/or\nset the GIMP environment PATH variable?")

def export_layers(image, only_visible, quality):
        try:    # Run on shell because of conflict with windows system command 'convert.exe'
                check_call(['/usr/local/bin/convert', '-version'], shell = True if os.name == 'nt' else False)
        except Exception as e:
                pdb.gimp_message("Error while executing 'convert' command:\n" +
                                 str(e) +
                                 "\n\nHave you installed the ImageMagic package\nand/or\nset the GIMP environment PATH variable?")
                return

        if not image.filename:
                pdb.gimp_message("Please save your file first!")
                return

        chooser = gtk.FileChooserDialog(title = None, action = gtk.FILE_CHOOSER_ACTION_SAVE,
                                        buttons = (gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL, gtk.STOCK_OPEN, gtk.RESPONSE_OK))
        chooser.set_current_folder(os.path.dirname(image.filename))
        chooser.set_current_name(os.path.splitext(image.filename)[0] + '.pdf')
        if chooser.run() != gtk.RESPONSE_OK:
                return
        filename = chooser.get_filename()
        chooser.destroy()

        version = gimp.version[0:2]
        gimp_version = float(version[0]) + float(version[1]) / 10.0

        layers_to_export = get_layers_to_export(image.layers, only_visible, gimp_version)
        img_files = []
        try:
                for layer in layers_to_export:
                        ext = '.jpg' if quality < 100 else '.png'
                        fullpath = mktmpfile(ext)
                        img_files.append(fullpath)
                        pic_filename = os.path.basename(fullpath)
                        if quality < 100:
                            pdb.file_jpeg_save(image, layer, fullpath, pic_filename, quality / 100.0, 0, 1, 0, "", 0, 1, 0, 2)
                        else:
                            pdb.file_png_save(image, layer, fullpath, pic_filename, 0, 9, 1, 1, 1, 1, 1)
                combine_images_into_pdf(img_files, filename)
        finally:
                for img in img_files:
                        try:
                                os.remove(img)
                        except:
                                pass

register(
        "export-layers-to-pdf", #name
        "Export layers to a multiple pages PDF file", #description
        "Export all layers to a single multiple pages PDF file", #help
        "helour", #author
        "helour", #copyright
        "2015", #year
        "Export layers to PDF", #menu label
        "*", # image format
        [       #input args. Format (type, name, description, default [, extra])
                (PF_IMAGE, "image", "Image", None),
                (PF_BOOL, "only_visible", "Only Visible Layers?", True),
                (PF_SLIDER, "quality", "Image quality", 100, (10, 100, 1)),
        ],
        [], #results. Format (type, name, description)
        export_layers, #callback
        menu=("<Image>/File/Export/"),
)

main()
