# CaissaGuardian.rb

[![Build Status](https://travis-ci.org/sashite/caissa_guardian.rb.svg?branch=master)](https://travis-ci.org/sashite/caissa_guardian.rb)
[![Gem Version](https://badge.fury.io/rb/caissa_guardian.svg)][gem]
[![Inline docs](https://inch-ci.org/github/sashite/caissa_guardian.rb.svg?branch=master)][inchpages]
[![Documentation](https://img.shields.io/:yard-docs-38c800.svg)][rubydoc]

> Two-player legal move generator.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "caissa_guardian"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install caissa_guardian

## Example

Let's replay [The Shortest Possible Game of Shogi](https://userpages.monmouth.com/~colonel/shortshogi.html).

First of all, we can install the [Shogi tablebase](https://github.com/sashite/pseudo_legal_move_tablebase-shogi.rb):

    $ gem install pseudo_legal_move_tablebase-shogi

And then, we can apply each move, one by one:

```ruby
require "pseudo_legal_move_tablebase/shogi"
require "caissa_guardian"

feen  = "s:l,s:n,s:s,s:g,s:-k,s:g,s:s,s:n,s:l/1,s:r,5,s:b,1/s:p,s:p,s:p,s:p,s:p,s:p,s:p,s:p,s:p/9/9/9/S:P,S:P,S:P,S:P,S:P,S:P,S:P,S:P,S:P/1,S:B,5,S:R,1/S:L,S:N,S:S,S:G,S:-K,S:G,S:S,S:N,S:L 0 -"
db    = PseudoLegalMoveTablebase::Shogi::DB
game  = CaissaGuardian::Game.load(db, feen)

moves = [
  [  56, 47, "S:P",  nil   ],  [   3, 11,  "s:g",  nil ],
  [  64, 24, "S:+B", "S:P" ],  [   5, 14,  "s:g",  nil ],
  [  24, 14, "S:+B", "S:G" ],  [   4,  3,  "s:-k", nil ],
  [ nil, 13, "S:G",  nil   ]
]

moves.each { |move| game.play!(move) }
```

When an illegal move is submitted, an error is raised:

```ruby
game.play!([3, 4, "s:-k", nil]) # => raise CaissaGuardian::Error::KingInCheck ([3, 4, "s:-k", nil])
```

## License

The code is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## About Sashite

This [gem](https://rubygems.org/gems/caissa_guardian) is maintained by [Sashite](https://sashite.com/).

With some [lines of code](https://github.com/sashite/), let's share the beauty of Chinese, Japanese and Western cultures through the game of chess!

[gem]: https://rubygems.org/gems/caissa_guardian
[inchpages]: https://inch-ci.org/github/sashite/caissa_guardian.rb
[rubydoc]: https://rubydoc.info/gems/caissa_guardian/frames
