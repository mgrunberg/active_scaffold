require 'test_helper'
require 'byebug'

class SearchColumnHelpersTest < ActionView::TestCase
  include ActiveScaffold::Helpers::SearchColumnHelpers
  include ActiveScaffold::Helpers::FormColumnHelpers

  def setup
    @record = Person.new

    controller.class.include ActiveScaffold::Finder
    controller.class.include ActiveScaffold::Actions::Core
    controller.class.include ActiveScaffold::Actions::FieldSearch
  end

  def field_search_params
    controller.send :field_search_params
  end

  def test_choices_for_boolean_search_ui
    @column = ActiveScaffold::DataStructures::Column.new(:adult, Person)

    assert_dom_equal "<select name=\"search[adult]\"><option value=\"\">- select -</option>\n<option value=\"true\">True</option>\n<option value=\"false\" selected=\"selected\">False</option></select>", active_scaffold_search_boolean(@column, :object => @record, :name => 'search[adult]', :value => '0')
  end

  def test_class_for_string_search_ui
    @column = ActiveScaffold::DataStructures::Column.new(:first_name, Person)

    assert_dom_equal "<span class=\"search_range\"><select name=\"search[first_name][opt]\" id=\"_opt\" class=\"as_search_range_option\"><option selected=\"selected\" value=\"%?%\">Contains</option>\n<option value=\"?%\">Begins with</option>\n<option value=\"%?\">Ends with</option>\n<option value=\"=\">=</option>\n<option value=\"&gt;=\">>=</option>\n<option value=\"&lt;=\"><=</option>\n<option value=\"&gt;\">></option>\n<option value=\"&lt;\"><</option>\n<option value=\"!=\">!=</option>\n<option value=\"BETWEEN\">Between</option>\n<option value=\"null\">Null</option>\n<option value=\"not_null\">Not Null</option></select><span id=\"_numeric\"><input type=\"text\" name=\"search[first_name][from]\" size=\"15\" autocomplete=\"off\" class=\"text-input\" /><span id=\"_between\" class=\"as_search_range_between\" style=\"display: none\"> - <input type=\"text\" name=\"search[first_name][to]\" id=\"_to\" size=\"15\" autocomplete=\"off\" class=\"text-input\" /></span></span></span>", active_scaffold_search_string(@column, :object => @record, :name => 'search[first_name]')
  end
end
