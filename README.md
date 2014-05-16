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


## Basic Concepts
- `AdminLibrary`
- `SubLibrary`
- `Collection`
- `PickupLocation`
- `Patron::Status`
- `Item::Status`
- `Item::ProcessingStatus`
- `Item::CirculationStatus`
- `Item::CallNumber`

## Record
The primary interface for an Aleph record

An example:

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

    holdings.to_a.each do |holding|

      holding.is_a?(Exlibris::Aleph::Holding)
      # => true
      
      holding_metadata = holding.metadata
      # => Exlibris::Aleph::Holding::Metadata

      holding_marc_record = holding_metadata.marc_record
      # => returns a MARC::Record
    end

    items = record.items
    # => Exlibris::Aleph::Items

    items.to_a.each do |item|

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
