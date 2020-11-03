# Recursive walk through a directory tree
# There is also Find.find and Dir.glob as alternatives
# Symbolic links, pointing nowhere, are ignored
# Symbolic links to directories are ignored
#  We will process the linked to directory, if it is in this tree;
#  But we don't want to break out of this tree, and go wondering through the file system.
# We also ignore special files (i.e. sockets, dev nodes, ...)
# 
class DirR
  VERSION = '1.0.1'
  # Directory listing. Ignoring symbolic links
  #
  # @param directory [String] directory to list
  # @param walk_sub_directories [Boolean] Recurse through the subdirectories
  # @param ignore_symlinks [Boolean] Skip over symbolic links to files
  # @yield [String, String, Boolean] Directory path, Filename, Symbolic Link true/false (only if ! ignore_symlinks)
  def self.walk_dir(directory:, walk_sub_directories: true, ignore_symlinks: true, debug: false, &block)
    puts "In #{directory}" if debug
    Dir.open(directory).each do |filename|
      puts " Got: #{filename}" if debug
      if filename != '.' && filename != '..' #ignore parent, and current directories.
        qualified_filename =  "#{directory}/#{filename}"
        begin
          stat_record =  File.stat(qualified_filename)  #File end
          lstat_record =  File.lstat(qualified_filename)#Link end 
        rescue Errno::ENOENT
          puts "  Skipping #{qualified_filename}" if debug
          next # Link points nowhere, so we ignore it, rather than stop.
        end
        link = lstat_record.symlink? 
        if stat_record.directory?
          if !link && walk_sub_directories 
            #recurse through sub-directories.
            #don't follow links to directories though, as they could take us anywhere, including looping.
            walk_dir( directory: qualified_filename,
                      walk_sub_directories: walk_sub_directories, 
                      ignore_symlinks: ignore_symlinks, 
                      debug: debug,
                      &block
                    )
            puts "Back In #{directory}" if debug
          end
        elsif stat_record.file? 
          # Ordinary file and not a link, or we are accepting links
          if !ignore_symlinks
            yield directory, filename, link
          elsif !link
            yield directory, filename
          end
        end
      end
    end
  end
end
