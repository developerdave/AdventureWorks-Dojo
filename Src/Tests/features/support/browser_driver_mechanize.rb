class BrowserDriverMechanize
  def initialize(mechanize_client)
    @mechanize = mechanize_client
  end

  def url
    @page.uri.to_s
  end

  def choose_ok_on_next_confirmation
  end

  def capture_entire_page_screenshot(filename, options='')
  end

  def go_to(url)
    @page = @mechanize.get url
  end

  def transform_to_xpath(locator)
    locator_is_an_xpath = locator =~ /^\//
    locator = "//*[@id='#{locator}']" unless locator_is_an_xpath
    return locator
  end

  def wait_for_element_present(locator, timeout=10)
    locator = transform_to_xpath(locator)
    is_element_present(locator).should == true
  end

  def is_element_present(locator)
    not @page.search(locator).empty?
  end

  def assert_element_is_present(locator)
    raise "Expected element #{locator} is not present" if self.is_element_present(locator) == false
  end

  def assert_element_is_not_present(locator)
    raise "Expected element #{locator} to not be present, but it was" if self.is_element_present(locator) == true
  end

  def wait_for_element_not_present(locator, timeout=10)
    #Improve error message
    locator = transform_to_xpath(locator)
    is_element_present(locator).should == false
  end

  def wait_for_expression(timeout, & block)

    if block_given? == false
      return
    end

    yield(self).should == true
  end

  def element_editable?(button_name)
    true
  end

  def click(locator)
    locator = transform_to_xpath(locator)
    elements = @page.search(locator)
    element = elements.first
    raise "No matching element found " + locator if not element
    if element.name == "input"
       if (element.attribute("type").value == "submit")  || (element.attribute("type").value == "image")
         formxpath = locator + "/ancestor::form"
         form = @page.search(formxpath).first
         action = form.attribute("action").value
         mechanize_form = @page.forms_with(:action => action).first
         @page = mechanize_form.submit
       end
    elsif element.name == "a"
      link = Mechanize::Page::Link.new(element, @mechanize, @page)
      @page = link.click
    end
  end

  def check(checkbox_name)
    checkbox = @page.forms.map  { |form| form.checkboxes_with(:name => checkbox_name)}.flatten.first
    checkbox.check
  end

  def select_radio_button(radio_button_list_name, value)
    radiobutton = @page.forms.map  { |form| form.radiobuttons_with(:name => radio_button_list_name, :value => value)}.flatten.first
    radiobutton.check
  end

  def wait_for_page_to_load(timeout=100)
    # timeout only there to keep Selenium happy
  end

  def number_of_elements(xpath)
    @page.search(xpath).size
  end

  def get_table_cell(table_xpath, row, column)
    table = @page.search(table_xpath).first
    row = table.xpath(".//tr[#{row}]")
    column = row.xpath(".//td[#{column + 1}]")
    column.text
  end

  def select_option(dropdown_name, option_text)
    dropdown = @page.forms.map { |f| f.fields_with(:name => dropdown_name)}.flatten.first
    option = dropdown.option_with(:text => option_text)
    option.select
  end

  def get_text(locator)
    @page.search(locator).first.text.gsub(/(\r\n|\n|\n\r)/,'').strip
  end

  def type(textbox_name, value)
    textbox = @page.forms.map { |f| f.field_with(:name => textbox_name) }.first
    textbox.value = value 
  end

  def get_html_source
    @page.body
  end
end