module Sprinkle
  module Installers
    # The user installer helps add groups.  You may pass flags as an option.
    # 
    # == Example Usage
    #
    #   package :users do
    #     add_group 'webguys', :flags => "--shell /usr/bin/zsh"
    #
    #     verify do
    #       has_group 'webguys'
    #     end
    #   end
    class Group < Installer
      api do
        def add_group(group, options={},  &block)
          install Group.new(self, group, options, &block)
        end
      end
      
      verify_api do
        def has_group(group)
          @commands << "egrep -i \"^#{group}:\" /etc/group"
        end
      end
      
      def initialize(package, groupname, options, &block) #:nodoc:
        super package, options, &block
        @groupname = groupname
      end
      
      protected 
      def install_commands #:nodoc:
        "addgroup #{@options[:flags]} #{@groupname}"
      end
    end
  end
end
