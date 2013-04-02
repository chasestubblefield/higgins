[![Build Status](https://travis-ci.org/chasetopher/higgins.png?branch=master)](https://travis-ci.org/chasetopher/higgins)
[![Code Climate](https://codeclimate.com/github/chasetopher/higgins.png)](https://codeclimate.com/github/chasetopher/higgins)
[![Dependency Status](https://gemnasium.com/chasetopher/higgins.png)](https://gemnasium.com/chasetopher/higgins)
[![Coverage Status](https://coveralls.io/repos/chasetopher/higgins/badge.png?branch=master)](https://coveralls.io/r/chasetopher/higgins)

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
