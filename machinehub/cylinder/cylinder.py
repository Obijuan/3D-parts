#------------------------------------------------------------------
#-- Hello world cylinder
#------------------------------------------------------------------
# (C) BQ, october-2015. Written by Juan Gonzalez (Obijuan)
#------------------------------------------------------------------
# Released under the GPL license
#------------------------------------------------------------------

#-- All these imports are needed by machinehub
import sys
FREECADPATH = '/usr/lib/freecad/lib/'
sys.path.append(FREECADPATH)
import FreeCAD
import Mesh
import os


##-------- Machinehub entry point
#-- file_path is mandatory
#-- Input parameters:
#--    * dimeter
#--    * height
#--------------------------------
def machinebuilder(diameter, height, file_path):
  
  #-- Get the freecad document
  document = os.path.abspath("cylinder.fcstd")
  doc = FreeCAD.openDocument(document)
  
  #-- Get the Cylinder object from the document
  cyl = doc.getObjectsByLabel("mycylinder")[0]
  
  #-- Set the cylinder's parameters
  if cyl:
      cyl.Radius = diameter / 2.0
      cyl.Height = height
      doc.recompute()
      
      #-- Export the file
      Mesh.export([cyl], file_path)

#-- This is for testing in console, before uploading to machinehub
#-- When the script is executed, the cylinder.stl is created
if __name__ == "__main__":
    machinebuilder(diameter = 10, height = 20, file_path = "./cylinder.stl")


