function Feature_PAL(patchsize)
addpath('../utils/');
imgdir = '/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/corpus_resized/';
savedir = '/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/baselines/001_MOPCNN/features/';
imgslistfpath = '/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/lists/Images.txt';
testndxesfpath = '/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/lists/NdxesTest.txt';
testndxes = readList(testndxesfpath, '%d');
imgslist = readList(imgslistfpath, '%s');

filenames = [];
for tid = testndxes(:)'
  filenames{end + 1} = imgslist{tid};
end

extractFeature(imgdir, filenames, savedir, patchsize)

