class AddSpanishBody < ActiveRecord::Migration

  def self.up
    Page.find(:all).each do |p|
      page_body = p.parts.detect { |pp| pp.name == "body" } || ""
      unless p.parts.detect { |pp| pp.name == "body_es" }
        spanish_body = PagePart.new
        spanish_body.name = "body_es"
        spanish_body.filter_id = page_body.filter_id
        spanish_body.content = page_body.content
        p.parts << spanish_body
        p.save
      end
    end
  end

  def self.down
    Page.find(:all).each do |p|
      p.parts.each do |pp|
        if pp.name == "body_es"
          pp.destroy
        end
      end
    end    
  end

end