require "arb/str/version"



# Examples:
#
#   String#enum:
#   'http://?/?/?'.enum '?',%w{domain1 domain2},%w{pictures videos jokes},1..3
#
#   => ["http://domain1/pictures/1", 
#       "http://domain1/pictures/2", 
#       "http://domain1/pictures/3", 
#       "http://domain1/videos/1", 
#       "http://domain1/videos/2", 
#       "http://domain1/videos/3", 
#       "http://domain1/jokes/1", 
#       "http://domain1/jokes/2",
#       "http://domain1/jokes/3",
#       "http://domain2/pictures/1",
#       "http://domain2/pictures/2",
#       "http://domain2/pictures/3",
#       "http://domain2/videos/1",
#       "http://domain2/videos/2",
#       "http://domain2/videos/3",
#       "http://domain2/jokes/1",
#       "http://domain2/jokes/2",
#       "http://domain2/jokes/3"]
#

module Arb
  module Str
    #Clean room here.
    Object.new.instance_eval do
      o=self
      e=:inner_enum
      o.singleton_class.send :define_method,e do |str,wildcard,enumerators|
        index=str.index wildcard
        return [str] unless index && enumerators.size>0
        [].tap {|res|
          enumerator=enumerators.shift
          #Make sure enumerator is enumerable here.
          enumerator=[enumerator] unless enumerator.respond_to? :each
          enumerator.each do |item|
            str_dup=str.dup
            str_dup[index..index+wildcard.length-1]=item.to_s
            res<<o.send(e,str_dup,wildcard,enumerators.dup)
          end
          #res.size==0 if the enumerator is empty(eg. [])
          res<<str if res.size==0
        }.flatten
      end
      #String#enum(wildcard,enumerator0,enumerator1,enumerator2,...)
      String.send :define_method, :enum do |*enumerators,&blk|
        return nil if enumerators.size < 1 
        return nil if enumerators[1..-1].map(&:to_s).include?(enumerators.first.to_s)
        #Wildcard could not be enumerated itself.
        o.send(e,self,enumerators.first,enumerators[1..-1]).tap do |res|
          res.each{|str| blk[str]} if blk
        end
      end
    end
  end
end
