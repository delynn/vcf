# encoding: US-ASCII

require 'forwardable'
require 'json'
require 'vcardigan'

class VCF
  class VCard
    extend Forwardable

    def initialize(data)
      @card = VCardigan.parse(data)
    end

    def attributes
      {
        uid: uid,
        addresses: addresses,
        email_addrsses: email_addresses,
        full_name: full_name,
        phone_numbers: phone_numbers
      }
    end

    def addresses
      (@card.adr || []).map do |adr|
        attribute_to_hash(adr)
      end
    end

    def full_name
      @card.fn.first.value
    end

    def email_addresses
      (@card.email || []).map do |email|
        attribute_to_hash(email)
      end
    end

    def phone_numbers
      (@card.tel || []).map do |phone|
        attribute_to_hash(phone)
      end
    end

    def uid
      @card.uid.first.value
    end

    def to_json
      attributes.to_json
    end

    def attribute_to_hash(attr)
      {
        text: attr.values.reject(&:empty?).join(' '),
        primary: (attr.params['preferred'] == 1 rescue false),
        type: [attr.params['type']].flatten.compact.map(&:capitalize).join(' ')
      }
    end
  end
end
