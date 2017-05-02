require 'nokogiri'
require 'ostruct'
require 'pry'

class XmlParser

  def self.to_hash(xml_file)
    library = {}
    doc = read_xml(xml_file)
    doc.xpath("//Artist").each do |xml_artist|
      artist_name = xml_artist.attributes["name"].value
      xml_artist.children.each do |xml_song|
        if xml_song.class == Nokogiri::XML::Element
          song = parse_song(xml_song, artist_name)
          if library[song.name[0].downcase].nil?
            library[song.name[0].downcase] = []
          end
          library[song.name[0].downcase] << song
        end
      end
    end
    library
  end

  private

  def self.parse_song(xml_song, artist)
    OpenStruct.new(id: xml_song.attributes["id"].value,
                   name: xml_song.attributes["name"].value,
                   artist: artist,
                   duration: xml_song.attributes["duration"].value.to_i)
  end

  def self.read_xml(xml_file)
    Nokogiri::XML(File.open(xml_file))
  end
end

#XmlParser.to_hash(ARGV[0])
