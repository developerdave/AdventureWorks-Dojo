module Pages

    $environment_path = 'http://localhost/coding-dojo'
    @@page_hash = {
        'about' => '/home/about',

    }

  def url_for page_name

    hash_value = get_complex_frontend_url(page_name) || @@page_hash[page_name] || get_backend_url(page_name)
    raise "The url for page #{page_name} is not defined" if not hash_value

    if(hash_value.is_a? Regexp)
      return hash_value
    else
      return (hash_value =~ /^http:/i ? "" : $environment_path) + hash_value
    end
  end

  def get_backend_url page_name
      case page_name
        when ''
        else
          raise "The url for page #{page_name} is not defined"
      end
    end
    
    def get_complex_frontend_url page_name
        case page_name
          when /Search All with enquiryId '([^']*)'/
            "/savings/search-all/?enquiryId=#{$1}"
        end
    end
end

World Pages
