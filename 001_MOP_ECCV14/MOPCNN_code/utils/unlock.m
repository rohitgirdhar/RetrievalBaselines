function unlock(fpath)
lock_fpath = [fpath '.lock'];
if exist(lock_fpath, 'dir')
  unix(['rmdir ' lock_fpath]);
end
