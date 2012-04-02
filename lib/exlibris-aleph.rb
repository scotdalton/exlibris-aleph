PATH = File.dirname(__FILE__) + "/exlibris/aleph/"
[ 
  'config/config_base',
  'config/config_by_sub_library',
  'config/pc_tab_exp_field_extended',
  'config/tab15_by_item_process_status',
  'config/tab15_by_item_status',
  'config/tab31',
  'config/tab37',
  'config/tab40',
  'config/tab_sub_library',
  'config/tab_www_item_desc',
  'tab_helper',
  'rest',
  'record',
  'patron',
  'bor_auth',
  'railtie'
].each do |library|
  require PATH + library if defined?(Rails)
end