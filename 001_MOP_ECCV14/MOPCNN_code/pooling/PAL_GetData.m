function PAL_GetData(patchsize)
addpath('../utils/');
imgslist = readList('/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/lists/Images.txt', '%s');
testndxes = readList('/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/lists/NdxesTest.txt', '%d');
filenames = arrayfun(@(x) imgslist{x}, testndxes, 'UniformOutput', false);

FEAT_DIR = '/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/baselines/001_MOPCNN/features/';
OUT_DIR = '/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/baselines/001_MOPCNN/pooled_features/';
image_dir = fullfile(FEAT_DIR, [num2str(patchsize) '/']);
out_path = fullfile(OUT_DIR, ['PAL_' num2str(patchsize) '.mat']);

if(patchsize==256)
    X = BuildALLGlobal(image_dir, filenames);
elseif(patchsize==128)
    [D, V, PCAV] = learnCodebook(image_dir, filenames, 500, 100);
    X = buildVLADALL(image_dir, filenames, D, V, PCAV);
elseif(patchsize==64)
    [D, V, PCAV] = learnCodebook(image_dir, filenames, 500, 100);
    X = buildVLADALL(image_dir, filenames, D, V, PCAV);
end
save(out_path, 'X', '-v7.3');
