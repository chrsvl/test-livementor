# JSON to CSV converter

This gem will convert a valid JSON file into a CSV file (using commas as separators).
It has not published on Rubygem, so the best way to interact with it is to install it locally.

## Installation
```
gem build json_to_csv.gemspec
gem install ./json_to_csv-0.0.1.gem
``` 

## Usage
To load it in an IRB:
```
irb -I lib -r json_to_csv
require 'json_to_csv'
```

To convert a file, use the public class method on the JsonToCsv class:
```
JsonToCsv.convert('users.json')
```

To view the created file, exist the IRB, then:
```
cat users.csv
```

## Testing

You can run the tests by running rspec:
```
rspec spec/
```