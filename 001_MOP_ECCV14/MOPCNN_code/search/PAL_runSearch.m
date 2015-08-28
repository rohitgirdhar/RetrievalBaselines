function PAL_runSearch()
if 1
  patchsizes = [256];
  outfdir = 'fullImg_l1/';
elseif 0
  patchsizes = [256 128];
  outfdir = 'fullImg_l1+2/';
elseif 0
  patchsizes = [256 128 64];
  outfdir = 'fullImg_mopcnn/';
end
addpath('../utils/');
imgslist = readList('/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/lists/Images.txt', '%s');
corpusndxes = readList('/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/lists/NdxesTest.txt', '%d');
testndxes = readList('/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/lists/NdxesPeopleTest.txt', '%d');

FINAL_FEAT_DIR = '/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/baselines/001_MOPCNN/pooled_features/';
OUT_DIR = fullfile('/IUS/vmr105/rohytg/data/005_ExtendedPAL2_moreTest/baselines/001_MOPCNN/matches/', outfdir);
unix(['mkdir -p ' OUT_DIR]);

% generate the feature representation
XX = [];
for patchsize = patchsizes
  feat = load(fullfile(FINAL_FEAT_DIR, ['PAL_' num2str(patchsize) '.mat']));
  X = normr(real(feat.X)); % ignore imaginary part if any
  XX = [XX, X];
end

% get the test ids
[test_ids, test_posns] = intersect(corpusndxes, testndxes);
test_feats = XX(test_posns, :);
D = pdist2(test_feats, XX, 'euclidean');
i = 1;
for tid = test_ids(:)'
  outfpath = fullfile(OUT_DIR, [num2str(tid) '.txt']);
  f = fopen(outfpath, 'w');
  [closest_dists, closest] = sort(D(i, :));
  for j = 1 : numel(closest)
    fprintf(f, '%d:%f ', corpusndxes(closest(j)) * 10000 + 1, 2 - closest_dists(j));
  end
  fclose(f);
  i = i + 1;
end

