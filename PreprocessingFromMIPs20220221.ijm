setBatchMode(true);

name = getTitle();
//run("Z Project...", "projection=[Max Intensity] all");
run("Split Channels");
selectWindow("C2-"+name);
run("Duplicate...", "title=Temp duplicate");
run("Enhance Contrast", "saturated=0.35");
waitForUser("Put in a walk average of 20");
run("Walking Average");
for (i=1; i<=nSlices;i++)
{
	
	setSlice(i);
	run("Enhance Local Contrast (CLAHE)", "blocksize=9 histogram=256 maximum=5 mask=*None*");
	run("Enhance Local Contrast (CLAHE)", "blocksize=9 histogram=256 maximum=5 mask=*None*");	
}
run("16-bit");
selectWindow("C1-"+name);
run("Slice Remover", "first="+nSlices-18+" last="+nSlices+" increment=1");
resetMinAndMax();
selectWindow("C2-"+name);
run("Slice Remover", "first="+nSlices-18+" last="+nSlices+" increment=1");
resetMinAndMax();
selectWindow("C3-"+name);
run("Slice Remover", "first="+nSlices-18+" last="+nSlices+" increment=1");
resetMinAndMax();
run("Merge Channels...", "c1=C1-"+name+" c2=C2-"+name+" c3=C3-"+name+" c4=walkAv create");
rename("Preprocessed-"+name);
setBatchMode("exit and display");