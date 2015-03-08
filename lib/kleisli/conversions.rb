require "kleisli/conversions/version"
require "kleisli/validation"

module Kleisli

  module Conversions

    module Lift
      def self.enrich(klass)
        klass.send(:include, Kleisli::Conversions::Lift)
      end

      def maybe
        Maybe(self)
      end

      def some
        # explicit request for some should support Some(nil)
        Kleisli::Maybe::Some.new(self)
      end

      def none
        None()
      end

      def success
        Success(self)
      end

      def failure
        Failure(self)
      end

      def left
        Left(self)
      end

      def right
        Right(self)
      end
    end

    module ToValidation

      GetRight = -> x { x.right }
      GetLeft = -> x { x.left }
      GetVal = -> x { x.value }
      GetEx = -> x { x.exception.message }

      def self.enrich(o_self, sc, fc, sp , fp)
        o_self.send(:define_method, :to_validation) do
          case
          when is_a?(sc)
            Success(sp.call(self))
          when is_a?(fc)
            Failure(fp.call(self))
          end
        end
      end
    end
  end

  class Validation

    class Success
      def fail_array
        self
      end

      def fail_hash(_)
        self
      end
    end

    class Failure
      def fail_array
        Failure([left])
      end

      def fail_hash(key)
        Failure(key => left)
      end
    end
  end

  class Maybe

    def to_success(msg)
      case
      when is_a?(Some)
        Success(value)
      when is_a?(None)
        Failure(msg)
      end
    end
  end

  class Either
    Conversions::ToValidation.
      enrich(self, Right, Left,
         Conversions::ToValidation::GetRight,
         Conversions::ToValidation::GetLeft)
  end

  class Try
    Conversions::ToValidation.
      enrich(self, Success, Failure,
        Conversions::ToValidation::GetVal,
        Conversions::ToValidation::GetEx)
  end
end
