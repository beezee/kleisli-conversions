require 'test_helper'

class ConversionsTest < Minitest::Test
  include Kleisli::Conversions
  Kleisli::Conversions::Lift.enrich(Object)

  def test_to_success
    assert_equal(Success(1), 1.some.to_success('nope'))
    assert_equal(Failure('nope'), 1.none.to_success('nope'))
  end

  def test_to_validation
    assert_equal(Success(1), 1.right.to_validation)
    assert_equal(Failure(1), 1.left.to_validation)
    assert_equal(Success(1), Try { 1 }.to_validation)
    assert_equal(Failure('nope'), Try { raise 'nope' }.to_validation)
  end

  def test_fail_hash
    assert_equal(Failure(a: 1), 1.failure.fail_hash(:a))
    assert_equal(Success(1), 1.success.fail_hash(:a))
  end

  def test_fail_array
    assert_equal(Failure([1]), 1.failure.fail_array)
    assert_equal(Success(1), 1.success.fail_array)
  end

  def test_lift
    assert_equal(Some(1), 1.maybe)
    assert_equal(None(), nil.maybe)
    assert_equal(Some(nil), nil.some)
    assert_equal(Some(1), 1.some)
    assert_equal(None(), 1.none)
    assert_equal(Success(1), 1.success)
    assert_equal(Failure(1), 1.failure)
    assert_equal(Right(1), 1.right)
    assert_equal(Left(1), 1.left)
  end
end
