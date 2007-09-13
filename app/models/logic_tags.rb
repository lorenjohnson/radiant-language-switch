module LogicTags
  include Radiant::Taggable
  class TagError < StandardError; end  

  tag 'switch' do |tag|
    content = ""
    tag.globals.matched, tag.globals.default = false, false
    tag.globals.value = tag.attr["value"]
    
    if !tag.globals.matched 
      tag.globals.default = true
      content = tag.expand
    end
    content
  end  
  
  tag 'switch:matches' do |tag|
    if tag.globals.value == tag.attr["value"] && !tag.globals.matched
      tag.globals.matched = true
      tag.expand
    end
  end

  tag 'switch:default' do |tag|
    if tag.globals.default
      tag.expand
    end
  end
  
end

