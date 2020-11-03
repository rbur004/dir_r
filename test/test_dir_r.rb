#!/usr/local/bin/ruby
require "test/unit"
require 'wikk_json'
#require_relative "../lib/dir_r.rb"
require 'dir_r'

class TestDirR < Test::Unit::TestCase
  def test_walk_dir_no_links
    puts "**************** test_walk_dir_no_links *****************"
    expected = {
      "a" => { :dir => '', :file => 'a', :link => false, :comment => "standard file" },
      "c/g" => { :dir => '', :file => 'g', :link => false, :comment => "standard file" },
      "c/h/i" => { :dir => 'c/h', :file => 'i', :link => false, :comment => "standard file" },
    }
    no_links = {}
    DirR.walk_dir(directory: "#{__dir__}/test_dir", walk_sub_directories: true, ignore_symlinks: true, debug: true) do |dir,fn,link|
      next if fn == '.DS_Store' # Ignore Mac OS X hidden directories
      dir_name = dir.gsub(/^#{__dir__}\/test_dir/, '') 
      index = "#{dir_name}/#{fn}".gsub(/^\//, '')
      no_links[index] = { :dir => dir_name, :file => fn, :link => link}
    end
    puts no_links.to_j

    expected.each do |k,v|
      puts k
      assert_not_nil(no_links[k])
    end
    
    no_links.each do |k,v|
      assert_not_nil(expected[k])
    end
  end
  
  def test_walk_dir_links
    puts "**************** test_walk_dir_links *****************"
    expected = {
      "a" => { :dir => '', :file => 'a', :link => false, :comment => "standard file" },
      "b" => { :dir => '', :file => 'b', :link => true, :comment => "link to a" },
      "c/g" => { :dir => '', :file => 'g', :link => false, :comment => "standard file" },
      "c/h/i" => { :dir => 'c/h', :file => 'i', :link => false, :comment => "standard file" },
    }
    with_links = {}
    DirR.walk_dir(directory: "#{__dir__}/test_dir", walk_sub_directories: true, ignore_symlinks: false, debug: true) do |dir,fn,link|
      next if fn == '.DS_Store' # Ignore Mac OS X hidden directories
      dir_name = dir.gsub(/^#{__dir__}\/test_dir/, '') 
      index = "#{dir_name}/#{fn}".gsub(/^\//, '')
      with_links[index] = { :dir => dir_name, :file => fn, :link => link}
    end
    puts with_links.to_j

    expected.each do |k,v|
      puts k
      assert_not_nil(with_links[k])
    end
    
    with_links.each do |k,v|
      assert_not_nil(expected[k])
    end
  end
  
  def test_walk_dir_no_links_no_recurse
    puts "**************** test_walk_dir_no_links_no_recurse *****************"
    expected = {
      "a" => { :dir => '', :file => 'a', :link => false, :comment => "standard file" },
    }
    with_links = {}
    DirR.walk_dir(directory: "#{__dir__}/test_dir", walk_sub_directories: false, ignore_symlinks: true, debug: true) do |dir,fn,link|
      next if fn == '.DS_Store' # Ignore Mac OS X hidden directories
      dir_name = dir.gsub(/^#{__dir__}\/test_dir/, '') 
      index = "#{dir_name}/#{fn}".gsub(/^\//, '')
      with_links[index] = { :dir => dir_name, :file => fn, :link => link}
    end
    puts with_links.to_j
    
    expected.each do |k,v|
      assert_not_nil(with_links[k])
    end
    
    with_links.each do |k,v|
      assert_not_nil(expected[k])
    end
    
  end
end

