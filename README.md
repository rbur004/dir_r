# dir_r

* Docs :: https://rbur004.github.io/dir_r/
* Source :: https://github.com/wikarekare/dir_r
* Gem :: https://rubygems.org/gems/dir_r

## DESCRIPTION:

Simple recursive walk through a directory, yielding the directory, filename and if the entry is a symbolic link.

## FEATURES/PROBLEMS:

* Symbolic links, that point nowhere, are skipped.
* Symbolic links, that point to directories, are skipped to avoid loops, double processing, and/or escaping the dir tree.

## SYNOPSIS:

  ```
   require 'dir_r'
   DirR.walk_dir(directory: "#{__dir__}/test_dir", walk_sub_directories: true, ignore_symlinks: true) do |dir,fn,link|
     puts "Directory Path: #{dir} Filename: #{fn} Is a link: #{link}"
   end
  ```

## REQUIREMENTS:

* require 'dir_r'

## INSTALL:

* sudo gem install dir_r

## LICENSE:

(The MIT License)

Copyright (c) 2020 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
