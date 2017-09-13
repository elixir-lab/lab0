defmodule CouldDoBetter do
  @moduledoc """
  This module contains a gnarly function. The module that follows
  below it contains some tests.

  The tests pass, but the code in this module needs some TLC.

  Refactor the function to use the match & transform style we've
  discussed. As a target, aim for a new set of functions that are each
  one line long, except where that makes the code worse.

  Remember to leave the original function's API intact. 

  We'll discuss a couple of people's solutions at the end.
  """



  def rpn(expr) do
    tokens = String.split(expr)
    stack = []
    execute(tokens, stack)
  end

  def execute(tokens, stack) do
    if length(tokens) == 0 do
      stack
    else
      { next, tokens } = List.pop_at(tokens, 0)
      stack = if next in [ "+", "-", "*", "/" ] do
        { val1, stack } = List.pop_at(stack, 0)
        { val2, stack } = List.pop_at(stack, 0)
        
        if next == "+" do
                  [ val1+val2 | stack ]
                else
                  if next == "-" do
                    [ val2-val1 | stack ]
                  else
                    if next == "*" do
                      [ val1*val2 | stack ]
                    else
                      [ val2/val1 | stack ]
                    end
                  end
                end
      else
        val = String.to_integer(next)
        [ val | stack ]
      end

      execute(tokens, stack)
    end
  end
  
end

#################### don't change below here ####################





ExUnit.start()

defmodule UglyTest do
  use ExUnit.Case

  import CouldDoBetter

  test "numbers are pushed onto the stack" do
    assert rpn("1 2") == [ 2, 1 ]
  end

  test "addition replaces top two with sum" do
    assert rpn("1 2 3 +") == [ 5, 1 ]
  end

  test "more complex expression" do
    assert rpn("1 2 3 * +") == [ 7 ]
  end

  test "and one more" do
    assert rpn("1 2 3 * + 3 - 1 1 + /") == [ 2 ]
  end

  
end
