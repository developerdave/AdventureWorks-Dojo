class BrowserDriverSelenium
  def initialize(selenium_client)
    @selenium = selenium_client
  end

  def go_to(url)
    @selenium.open(url)
    @selenium.wait_for_page_to_load
    wait_for_all_javascript_loaded
  end

  def choose_ok_on_next_confirmation
    @selenium.choose_ok_on_next_confirmation
  end

  def choose_cancel_on_next_confirmation
    @selenium.choose_cancel_on_next_confirmation
  end

  def click(locator)
    wait_for_element_present(locator,5)
    @selenium.click(locator)
  end

  def run_script(script)
    @selenium.run_script(script)
  end

  def check(checkbox_name)
    @selenium.click(checkbox_name)
  end

  def uncheck(checkbox_name)
    if (is_checked(checkbox_name))
      @selenium.check(checkbox_name)
    end
  end

  def get_value(locator)
    @selenium.get_value(locator)
  end

  def set_value(locator, value)
    @selenium.get_eval("window.document.getElementById('#{locator}').value = '#{value}'")
  end

  def select_option(dropdown, option)
    @selenium.select(dropdown, option)
  end

  def url
    @selenium.location
  end

  def type(textbox, value)
    @selenium.type(textbox, value)
  end

  def get_text(locator)
    @selenium.get_text(locator)
  end

  def select_window(window)
    @selenium.select_window(window)
  end

  def number_of_elements(xpath)
    @selenium.get_xpath_count(xpath).to_i
  end

  def get_table_cell(table_xpath, row, column)
    @selenium.get_table("#{table_xpath}.#{row}.#{column}")
  end

  def fire_event(locator, event)
    @selenium.fire_event(locator, event)
  end

  def wait_for_page_to_load(timeout = 20)
    @selenium.wait_for_page_to_load(timeout)
  end

  def wait_for_text(text, timeout)
    @selenium.wait_for(:wait_for =>:text, :text => text, :timeout_in_seconds => timeout)
  end

  def get_confirmation()
    @selenium.get_confirmation
  end

  def get_attribute(xpath)
    @selenium.get_attribute(xpath)
  end

  def wait_for_expression(timeout, &block)
    i = 0

    if block_given? == false
      return
    end

    while (i < 10 * timeout)
      return if (yield self == true)

      sleep 0.1
      i = i + 1
    end

    raise "Timeout waiting for condition to be true"
  end

  def wait_for_element_not_present(locator, timeout=10)
    wait_for_expression timeout do
      @selenium.is_element_present(locator) == false
    end
  end

  def wait_for_element_present(locator, timeout=10)
    wait_for_expression timeout do
      @selenium.is_element_present(locator)
    end
  end

  def assert_element_is_present(locator)
    raise "Expected element #{locator} is not present" if @selenium.is_element_present(locator) == false
  end

  def assert_element_is_not_present(locator)
    raise "Expected element #{locator} to not be present, but it was" if @selenium.is_element_present(locator) == true
  end

  def is_element_present(locator)
    @selenium.is_element_present(locator, 20)
  end

  def is_editable(locator)
    @selenium.is_editable(locator)
  end

  def element_editable?(id)
    @selenium.is_element_present("//input[@id=\"#{id}\" and not(@disabled=\"disabled\")]")
  end

  def element_not_editable?(id)
    @selenium.is_element_present("//input[@id=\"#{id}\" and (@disabled=\"disabled\")]")
  end

  def wait_for_location_loaded(location, timeout)
    i = 0

    while (i < 10 * timeout)
      if CGI::unescape(@selenium.location) == CGI::unescape(location)
        return
      end

      sleep 0.1

      i = i + 1
    end
    raise "Timeout waiting for page #{location} to be loaded ----- #{CGI::unescape(@selenium.location)} != #{CGI::unescape(location)}"
  end

  def wait_for_all_javascript_loaded
    script = "this.browserbot.getCurrentWindow().javascriptLoadCompleted"
    wait_for_expression 20 do
      @selenium.get_eval(script)
    end
  end

  def capture_entire_page_screenshot(filename)
    @selenium.capture_entire_page_screenshot(filename, '')
  end

  def select_radio_button(radio_button_list_name, value)
    @selenium.click("//input[@value='#{value}' and @name='#{radio_button_list_name}']")
  end

  def get_html_source
    @selenium.get_html_source
  end

  def is_visible(locator)
    @selenium.is_visible(locator)
  end
  
  def get_selected_label(locator)
    @selenium.get_selected_label(locator)
  end

  def is_checked(locator)
    return @selenium.is_checked(locator)
  end

  def allow_native_xpath(value)
    @selenium.allow_native_xpath(value)
  end
  
  def delete_cookie(name, optionsString)
	@selenium.delete_cookie(name, optionsString);
  end
  
  def delete_all_cookies()
    @selenium.delete_all_visible_cookies();
  end
end
