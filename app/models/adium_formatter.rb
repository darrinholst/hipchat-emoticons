require 'open-uri'
require 'zip'

class AdiumFormatter
  class << self
    def format(emoticons)
      plist = {"AdiumSetVersion" => 1.3, "Emoticons" => {}}

      Tempfile.create('zippy.zip') do |tempfile|
        Zip::OutputStream.open(tempfile) {|whatevs|} #Initializes it as a zip file for the open below

        Zip::File.open(tempfile.path) do |zipfile|
          emoticons.each do |e|
            Tempfile.create(e.shortcut) do |image|
              image.binmode
              image << open(e.url).read
              image.flush
              zipfile.add("HipChat.AdiumEmoticonSet/#{e.shortcut}.png", image.path)
              zipfile.commit

              plist["Emoticons"]["#{e.shortcut}.png"] = {
                "Equivalents" => ["(#{e.shortcut})"],
                "Name" => "(#{e.shortcut})"
              }
            end
          end

          Tempfile.create('plist') do |plistfile|
            plistfile << Plist::Emit.dump(plist)
            plistfile.flush
            zipfile.add('HipChat.AdiumEmoticonSet/Emoticons.plist', plistfile.path)
            zipfile.commit
          end
        end

        File.read(tempfile.path)
      end
    end
  end
end
