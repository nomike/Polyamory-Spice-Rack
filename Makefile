.PHONY: upload

spice-rack.stl: spice-rack.scad heart-icon.svg infinity.svg
	openscad -o $@ $<

publish: spice-rack.stl
	thingiverse-publisher

clean: 
	rm -f spice-rack.stl
	
