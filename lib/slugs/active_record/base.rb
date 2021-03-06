module Slugs
  module ActiveRecord
    module Base
      extend ActiveSupport::Concern

      def to_param
        self.class.sluggable? ? (slug_changed? ? slug_was : slug) : super
      end

      protected

      def generate_slug
        unless slug_changed?
          options = self.class.slug
          case options
          when Symbol
            value = send(options)
          when Array
            value = options.each.map{ |p| send(p) }.join(' ')
          else
            value = options.call(self) if options.respond_to? :call
          end
          value = value.to_s.parameterize
          if value.present? and value != slug
            previous_value = self.class.unscoped.find_previous_slug(value)
            if previous_value.present?
              index = Regexp.new("#{value}-([0-9]+)$").match(previous_value)
              if index.present?
                value << "-#{index[1].to_i + 1}"
              else
                value << '-1'
              end
            end
            self.slug = value
          end
        end
      end

      module ClassMethods

        attr_accessor :slug

        def inherited(subclass)
          subclass.slug = slug
          super
        end
 
        def sluggable?
          slug.present?
        end

        def has_slug(*args, &block)
          unless sluggable?
            if respond_to? :translatable? and translatable?
              include Slugs::ActiveRecord::Translatable
              attr_translatable :slug
              before_validation :generate_slugs
            else
              include Slugs::ActiveRecord::NonTranslatable
              before_validation :generate_slug
            end
            if block_given?
              self.slug = block
            else
              self.slug = args.size == 1 ? args[0] : args                              
            end
          end
        end
 
      end
    end
  end
end
