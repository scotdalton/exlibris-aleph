[![Gem Version](https://badge.fury.io/rb/exlibris-aleph.png)](http://badge.fury.io/rb/exlibris-aleph)
[![Build Status](https://api.travis-ci.org/scotdalton/exlibris-aleph.png?branch=master)](https://travis-ci.org/scotdalton/exlibris-aleph)
[![Dependency Status](https://gemnasium.com/scotdalton/exlibris-aleph.png)](https://gemnasium.com/scotdalton/exlibris-aleph)
[![Code Climate](https://codeclimate.com/github/scotdalton/exlibris-aleph.png)](https://codeclimate.com/github/scotdalton/exlibris-aleph)
[![Coverage Status](https://coveralls.io/repos/scotdalton/exlibris-aleph/badge.png?branch=master)](https://coveralls.io/r/scotdalton/exlibris-aleph)

# Exlibris::Aleph
Exlibris::Aleph offers a set of libraries for interacting with the ExLibris Aleph ILS.

## Exlibris::Aleph::Patron
Exlibris::Aleph::Patron provides access to the Aleph Patron REST API.

### Example of Exlibris::Aleph::Patron in action
    patron = 
      Exlibris::Aleph::Patron.
        new(patron_id: "S0M31D", rest_url: "http://aleph.institution.edu")
    patron.address # Returns a Hash of the of patron's address
    patron.loans # Returns an Array of institution Hashes, each containing an Array of the patron's loans for that institution
    patron.renew_loans # Renews all loans
    patron.renew_loans("ADM5000000001") # Renews loan of item 00000001 in ADM50
    patron.place_hold("ADM50", "SBLIB", "00000001", "00000001", {:pickup_location => "SBLIB"}) # Places hold on the specified item for pickup at SBLIB
  
## Exlibris::Aleph::Record
Provides access to the Aleph Record REST API.

### Example of Exlibris::Aleph::Record in action
    record = 
      Exlibris::Aleph::Record.
        new(bib_library: "ADM50", record_id: "00000001", rest_url: "http://aleph.institution.edu")
    record.bib # Returns a MARC::Record with bibliographic metadata
    record.holdings # Returns and Array of MARC::Records respresenting the record's holdings
    record.items # Returns and Array of Hashes representing the record's items

## Exlibris::Aleph.configure
Exlibris::Aleph can be configured at startup in an initializer.

    # Placed this in an initializer.
    Exlibris::Aleph.configure { |c|
      c.base_url = "http://aleph.institution.edu"
      c.tab_path = "/mnt/aleph_tab"
      c.adms = ["ADM50", "ADM51"]
    }

It can also read from a yaml file.

    # Placed this in an initializer.
    Exlibris::Aleph.configure { |c|
      config.load_yaml File.expand_path("#{File.dirname(__FILE__)}/../config/aleph.yml",  __FILE__)
    }

## Exlibris::Aleph::TabHelper
Exlibris::Aleph::TabHelper provides a way to access the various tab settings for patrons, patron\_permissions, items, item_permission (both by item status and by item processing status), collections and pickup locations. It also provides convenience methods for common tasks like getting the pickup location for a given combination of item status, item process status and borrower status or getting an item's web text.  Support a 

### Example of Exlibris::Aleph::TabHelper in action
    # Placed this in an initializer.
    Exlibris::Aleph.configure { |c|
      c.tab_path = "/mnt/aleph_tab"
      c.adms = ["ADM50", "ADM51"]
    }

    # Rake task to refresh the config yml files
    rake exlibris:aleph:refresh

    # Get an instance of TabHelper
    helper = Exlibris::Aleph::TabHelper.instance
    helper.sub_library_text("SBLIB") # Returns display text for the give code
    helper.sub_library_adm("SBLIB") # Returns ADM for the give code
    helper.item_pickup_locations({:adm_library_code => "ADM50", :sub_library_code => "SBLIB", :bor_status => "51"}) # Returns the pickup locations for the given parameters
    helper.collection_text({:adm_library_code => "ADM50", :sub_library_code => "SBLIB", :collection_code => "MAIN"}) # Returns the collection display text for the give parameters
    helper.item_web_text({:adm_library_code => "ADM50", :item_process_status => "Item Process Status"}) # Returns the web text for the given parameters
    helper.item_web_text({:adm_library_code => "ADM50", :sub_library_code => "SBLIB", :item_process_status_code => "DP"}) # Returns the web text for the given parameters

### Configure irrelevant sub libraries for TabHelper
To configure the gem to ignore sub libraries pulled from Aleph but not relevant to working with permissions call the following setter with an array of sub library Aleph codes.

    # Place this in an initializer to replace the current irrelevant sub libraries.
    Exlibris::Aleph.configure { |c|
      c.irrelevant_sub_libraries = ["IRRLIB1", "IRRLIB2"]
    }

## Rake task
Exlibris::Aleph has a rake task that refreshes the mounted tables.  Outside of Rails add `require 'exlibris-aleph'` to your Rakefile.
Inside of Rails it should just work.

## Exlibris::Aleph::BorAuth
Exlibris::Aleph::BorAuth provides access to the BorAuth Aleph XService.

### Example of Exlibris::Aleph::BorAuth in action
    bor_auth = 
      Exlibris::Aleph::BorAuth.
        new("http://aleph.institution.edu", "ADM50", "SBLIB", "N", "S0M31D", "V3R1F1C@T10N")
    permissions = bor_auth.permissions # Return a Hash of permissions based on the Exlibris::Aleph::BorAuth instance

