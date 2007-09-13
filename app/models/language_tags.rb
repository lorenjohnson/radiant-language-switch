module LanguageTags
  include Radiant::Taggable
  class TagError < StandardError; end  

  tag 'language' do |tag|
    content = ""
    tag.globals.matched, tag.globals.default = false, false

    if @language.blank? || @language == "browser"
      langs.each do |l|
        tag.globals.lang = l
        content << tag.expand
      end
    else
      tag.globals.lang = @language
      content << tag.expand
    end
    
    if !tag.globals.matched
      tag.globals.default = true
      content = tag.expand
    end
    content
  end  
  
  tag 'language:matches' do |tag|
    if tag.globals.lang == tag.attr["value"] && !tag.globals.matched
      tag.globals.matched = true
      tag.expand
    elsif tag.globals.default == true && tag.attr["default"] == "true"
      tag.expand
    end
  end
  
  tag 'language_switch' do |tag|
    %{<a href="?language=#{tag.attr["language"]}" class="#{tag.attr["class"]}" style="#{tag.attr["style"]}">#{tag.expand}</a>}
  end

  tag 'language_reset' do |tag|
    %{<a href="?language=browser" class="#{tag.attr["class"]}" style="#{tag.attr["style"]}">#{tag.expand}</a>}
  end

  tag 'languages' do |tag|
    langs.join("|")
  end

  def langs
    langs = (@request.env["HTTP_ACCEPT_LANGUAGE"] || "").scan(/[^,\s]+/)
    q = lambda { |str| /;q=/ =~ str ? Float($') : 1 }
    langs = langs.collect do |ele|
      [q.call(ele), ele.split(/;/)[0].downcase]
    end.sort { |l, r| r[0] <=> l[0] }.collect { |ele| ele[1] }
  end
  
end