[![Gem Version](https://badge.fury.io/rb/exlibris-aleph.png)](http://badge.fury.io/rb/exlibris-aleph)
[![Build Status](https://api.travis-ci.org/scotdalton/exlibris-aleph.png?branch=master)](https://travis-ci.org/scotdalton/exlibris-aleph)
[![Dependency Status](https://gemnasium.com/scotdalton/exlibris-aleph.png)](https://gemnasium.com/scotdalton/exlibris-aleph)
[![Code Climate](https://codeclimate.com/github/scotdalton/exlibris-aleph.png)](https://codeclimate.com/github/scotdalton/exlibris-aleph)
[![Coverage Status](https://coveralls.io/repos/scotdalton/exlibris-aleph/badge.png?branch=master)](https://coveralls.io/r/scotdalton/exlibris-aleph)

# Exlibris::Aleph
Exlibris::Aleph offers a set of libraries for interacting with the ExLibris Aleph ILS.

## API

## Tables
`Tables` are accessed through the `TablesManager`.

## Config
There are several configuration options
- `base_url`: a String representing the base url for Aleph, e.g. http://aleph.library.edu
- `rest_url`: a String representing rest url for the Aleph REST API, e.g. http://aleph.library.edu:1891
- `adms`: an Array of administrative library codes, e.g. ['ADM50', 'ADM51']
- `table_path`: the path to the Aleph tables on the system
- `irrelevant_sub_libraries`: an Array or Sub Library codes to ignore

An example:

```ruby
Exlibris::Aleph.configure do |config|
  config.base_url = 'http://aleph.library.edu'
  config.rest_url = 'http://aleph.library.edu:1891'
  config.adms = ['ADM50', 'ADM51']
  config.table_path = "/mnt/aleph_tab"
end

```

## Basic Concepts
- `AdminLibrary`: an administrative library
  ```ruby
  admin_library = AdminLibrary.new('ADM50')
  # => Exlibris::Aleph::AdminLibrary

  admin_library.code
  # => 'ADM50'
  ```
- `SubLibrary`: a sub library
  ```ruby
  sub_library = SubLibrary.new('SUB', 'Sub Library', admin_library)
  # => Exlibris::Aleph::SubLibrary

  sub_library.code
  # => 'SUB'

  sub_library.display
  # => 'Sub Library'

  sub_library.admin_library
  # => Exlibris::Aleph::AdminLibrary
  ```
- `Collection`: a collection
  ```ruby
  collection = Collection.new('MAIN', 'Main Collection', sub_library)
  # => Exlibris::Aleph::Collection

  collection.code
  # => 'MAIN'

  collection.display
  # => 'Main Collection'

  collection.sub_library
  # => Exlibris::Aleph::SubLibrary
  ```
- `PickupLocation`: a pickup location
- `Patron::Status`: a patron status
  ```ruby
  patron_status = Exlibris::Aleph::Patron::Status.new('01', 'Regular patron')
  # => Exlibris::Aleph::Patron::Status

  patron_status.code
  # => '01'

  patron_status.display
  # => 'Regular patron'
  ```
- `Item::Status`: an item status
  ```ruby
  item_status = Exlibris::Aleph::Item::Status.new('01', 'Regular loan')
  # => Exlibris::Aleph::Item::Status

  item_status.code
  # => '01'

  item_status.display
  # => 'Regular loan'
  ```
- `Item::ProcessingStatus`: an item circulation status
  ```ruby
  processing_status = Exlibris::Aleph::Item::ProcessingStatus.new('DP', 'Depository')
  # => Exlibris::Aleph::Item::ProcessingStatus

  processing_status.code
  # => 'DP'

  processing_status.display
  # => 'Depository'
  ```
- `Item::CirculationStatus`
- `Item::CallNumber`

## Record
The primary interface for an Aleph record

An example:

```ruby
record_id = '000000001'

admin_library = Exlibris::Aleph::AdminLibrary.new('BIB01')
# => Exlibris::Aleph::AdminLibrary

record = Exlibris::Aleph::Record.new(record_id, admin_library)
# => Exlibris::Aleph::Record

bibliographic_metadata = record.metadata
# => Exlibris::Aleph::Record::Metadata

bibliographic_marc_record = bibliographic_metadata.marc_record
# => returns a MARC::Record

holdings = record.holdings
# => Exlibris::Aleph::Holdings

holdings.each do |holding|

  holding.is_a?(Exlibris::Aleph::Holding)
  # => true
  
  holding_metadata = holding.metadata
  # => Exlibris::Aleph::Holding::Metadata

  holding_marc_record = holding_metadata.marc_record
  # => returns a MARC::Record
end

items = record.items
# => Exlibris::Aleph::Items

items.each do |item|

  item.is_a?(Exlibris::Aleph::Item)
  # => true

  item_collection = item.collection
  # => Exlibris::Aleph::Collection

  item_status = item.status
  # => Exlibris::Aleph::Item::Status

  item_processing_status = item.processing_status
  # => Exlibris::Aleph::Item::ProcessingStatus

  item_circulation_status = item.circulation_status
  # => Exlibris::Aleph::Item::CirculationStatus

  item_call_number = item.call_number
  # => Exlibris::Aleph::Item::CallNumber

  item_on_shelf = item.on_shelf?
  # => true
end
```

## Patron
The primary interface for an Aleph patron

An example:

```ruby
patron_id = 'N1234567890'

patron = Exlibris::Aleph::Patron.new(patron_id)
# => Exlibris::Aleph::Patron

address = patron.address
# => Exlibris::Aleph::Patron::Address

record_id = 'BIB01000000001'

patron_record = patron.record(record_id)
# => Exlibris::Aleph::Patron::Record

patron_record_circulation_policy = patron_record.circulation_policy
# => Exlibris::Aleph::Patron::Record::CirculationPolicy

item_id = 'ADM5000000000101'

patron_record_item = patron_record.item(item_id)
# => Exlibris::Aleph::Patron::Record::Item

patron_record_item_item = patron_record_item.item
# => Exlibris::Aleph::Item

patron_record_item_circulation_policy = patron_record_item.circulation_policy
# => Exlibris::Aleph::Patron::Record::Item::CirculationPolicy

```
