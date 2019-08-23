// Generate for Network functions

current_path = get_absolute_file_path("genhelpscript.sce");

pMacrosAll = fullpath(current_path);
pHelpAll = fullpath(current_path + '/../help/en_US');
files_All = findfiles(pMacrosAll, '*.sci');
for i = 1:size(files_All, '*')
  try
  help_from_sci(pMacrosAll + filesep() + files_All(i), pHelpAll);
    catch
    disp(files_All(i));
    end
end





//help_from_sci(pMacrosAll + filesep() + 'sos2tf.sci', pHelpAll);
//help_from_sci(pMacrosAll + filesep() + 'tf2sos.sci', pHelpAll);
//help_from_sci(pMacrosAll + filesep() + 'tf2zpk.sci', pHelpAll);
//help_from_sci(pMacrosAll + filesep() + 'zp2sos.sci', pHelpAll);
//help_from_sci(pMacrosAll + filesep() + 'stem.sci', pHelpAll);
//help_from_sci(pMacrosAll + filesep() + 'time_response.sci', pHelpAll);
//help_from_sci(pMacrosAll + filesep() + 'unwrap.sci', pHelpAll);
// Build all
cd(fullpath(current_path + '/..'));
exec('builder.sce');
