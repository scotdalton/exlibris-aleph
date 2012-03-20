PATH = File.dirname(__FILE__) + "/exlibris-aleph/"
[ 
  'rest',
  'record',
  'patron',
  'bor_auth'
].each do |library|
  require PATH + library
end