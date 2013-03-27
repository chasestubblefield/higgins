[![Build Status](https://travis-ci.org/chasestubblefield/higgins.png?branch=master)](https://travis-ci.org/chasestubblefield/higgins)
[![Code Climate](https://codeclimate.com/github/chasestubblefield/higgins.png)](https://codeclimate.com/github/chasestubblefield/higgins)
[![Dependency Status](https://gemnasium.com/chasestubblefield/higgins.png)](https://gemnasium.com/chasestubblefield/higgins)
[![Coverage Status](https://coveralls.io/repos/chasestubblefield/higgins/badge.png?branch=master)](https://coveralls.io/r/chasestubblefield/higgins)

Development
-----------

System dependencies:
```
git
ruby 2.0.0-p0
bundler
redis
sqlite3 (development)
mysql (production)
```

```bash
bundle install
```

Run tests:
```bash
bin/rake
```

Server:
```bash
bin/rails s
```

Worker:
```bash
QUEUE=* bin/rake resque:work
```
