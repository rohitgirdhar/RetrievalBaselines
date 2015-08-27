function res = lock(fpath)
lock_fpath = [fpath '.lock'];
if exist(fpath, 'file') || exist(lock_fpath, 'dir')
  res = false;
  return;
end
unix(['mkdir -p ' lock_fpath]);
res = true;
