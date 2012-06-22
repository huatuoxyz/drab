Drab.gem
====

Terminal-based Twitter Client with Streaming API support.
Only supports Ruby 1.9.

### Launch

    $ drab

Commands
----

### Tweet

    ⚡ Hello World!

### Show

    ⚡ $xx

**$xx** is the alias of tweet id.

### Reply

    ⚡ $xx hi!

### Delete

    ⚡ :delete $xx

### Retweet

    ⚡ :retweet $xx

### Timeline

    ⚡ :recent
    ⚡ :recent jugyo

### Lists

    ⚡ :recent yugui/ruby-committers

### Search

    ⚡ :search #ruby

### Eval

    ⚡ :eval Time.now

### Exit

    ⚡ :exit

### Reconnect

    ⚡ :reconnect

### Restart

    ⚡ :restart

### Threads

    ⚡ :thread $xx

### Install Plugins

    ⚡ :plugin_install https://gist.github.com/899506

### Alias

    ⚡ :alias :rt :retweet

### Tweet Ascii Art

    ⚡ :update[ENTER]
    [input EOF (e.g. Ctrl+D) at the last]
        ⚡
       ⚡
        ⚡
       ⚡
    ^D

### View Ascii Art

    # permanently
    ⚡ :eval config[:raw_text] = true

    # temporarily(with :status, :recent or :thread etc...)
    ⚡ :aa :status $aa

### Stream Filter Tracking

    # keywords
    ⚡ :filter keyword drabgem twitter

    # users
    ⚡ :filter user jugyo matsuu

    # return to normal user stream
    ⚡ :filter off

### Show config

    # All config
    ⚡ :config

    # config for :key
    ⚡ :config key

### Set config

    # set config for :key to (evaluated) value
    ⚡ :config key 1 + 1
    {
        :key => 2
    }
    ⚡ :config key {foo: 1, bar: 2}
    {
        :key => {
            :foo => 1,
            :bar => 2
        }
    }
    # merge new config if both are Hash
    ⚡ :config key {bar: 3}
    {
        :key => {
            :foo => 1,
            :bar => 3
        }
    }

And more!

Configuration
----

The default drab directory is ~/.drab.

The config file is **~/.drab/config**.

### Changing the drab directory

You can change the directory at launch by entering a directory as an argument. For example:

    $ drab ~/.drab_foo

### Changing the colors for user name

    # ~/.drab/config
    # For example, to exclude blue:
    Drab.config[:colors] = (31..36).to_a - [34]

### Changing the color scheme

    # ~/.drab/config
    Drab.config[:color] = {
      :info => 34,
      :notice => 41,
      :event  => 46,
      :url => [4, 34]
    }

### Tracking specified keywords

    # ~/.drab/config
    Drab.config[:api] = {
      :method => 'POST',
      :host => 'stream.twitter.com',
      :path => '/1/statuses/filter.json',
      :ssl => true,
      :filters => %w(Twitter Drab)
    }

### Tracking specified users

    # ~/.drab/config
    Drab.config[:api] = {
      :method => 'POST',
      :host => 'stream.twitter.com',
      :path => '/1/statuses/filter.json',
      :ssl => true,
      :params => {
        :follow => '6253282,183709371' # @twitterapi @sitestreams
      }
    }

### Defining aliases

    # ~/.drab/config
    Drab.alias_command :rt, :retweet

### Default confirmation type

    # ~/.drab/config
    Drab.config[:confirm_type] = :n

### HTTP proxy support

Please set environment variable *http_proxy* if you want drab to use an http proxy.
    
Desktop Notifications
----

To enable desktop notifications, install one of the following:

* ruby-growl (gem install ruby-growl)
* growlnotify (http://growl.info/extras.php#growlnotify)
* notify-send (sudo aptitude install libnotify-bin)
* libnotify (https://github.com/splattael/libnotify)

Call Drab.notify for desktop notification.
You can try it by using the :eval command:

    ⚡ :eval notify 'Hello World!'

Plugins
----

See [https://github.com/jugyo/drab/wiki](https://github.com/jugyo/drab/wiki)

Making Plugins
----

**~/.drab/plugin** is the directory for plugins.
At launch, Drab tries to load files under this directory.
The block that is specified for Drab.init will be reloaded at any command line input.

### Defining your commands

#### A command named 'foo':

    Drab.init do
      command :foo do
        puts "foo!"
      end
    end

#### Handling the command args:

    Drab.init do
      command :hi do |m|
        puts "Hi #{m[1]}!"
      end
    end

'm' is a [http://www.ruby-doc.org/core/classes/MatchData.html](MatchData) object.

#### Using regexp:

    Drab.init do
      # Usage: :add 10 20
      command %r|^:add (\d+)\s+(\d+)|, :as => :add do |m|
        puts m[1].to_i + m[2].to_i
      end
    end

### Handling outputs

#### Keyword notifier:

    Drab.init do
      output do |item|
        next unless item["_stream"]
        if item["text"] =~ /ruby/i
          notify "#{item["user"]["screen_name"]}: #{item["text"]}"
        end
      end
    end

#### Favorite notifier:

    Drab.init do
      output do |item|
        case item["event"]
        when "favorite"
          notify "[favorite] #{item["source"]["screen_name"]} => #{item["target"]["screen_name"]} : #{item["target_object"]["text"]}"
        end
      end
    end

### Defining filters for output

#### Filtering by keywords

    Drab.init do
      output_filter do |item|
        if item["_stream"] && item["text"]
          item["text"] =~ /ruby/i
        else
          true
        end
      end
    end

### Replacing the output for tweets

    Drab.init do
      output :tweet do |item|
        next unless item["text"]
        name = item["user"]["screen_name"]
        puts "#{name.c(color_of(name))}: foo"
      end
    end

### Defining completion

    Drab.init do
      completion do |text|
        ['jugyo', 'drab', '#eqrb'].grep(/^#{Regexp.quote(text)}/)
      end
    end

TODO
----

* mark my tweet
* Drab should parse ARGV
* ruby1.9nize
* guideline for plugin
* deal proxy
* spec

Copyright
----

Copyright (c) 2011 jugyo. See LICENSE.txt for further details.
