package dto;

import java.io.Serializable;

public class ParsedAddress {
    private String alias;
    private String zipcode;
    private String address;
    private String detail;
    private String phone;
    private String recipient;
    private boolean defaultAddress;

    public ParsedAddress(String alias, String zipcode, String address, String detail, String phone, String recipient,
			boolean defaultAddress) {
		super();
		this.alias = alias;
		this.zipcode = zipcode;
		this.address = address;
		this.detail = detail;
		this.phone = phone;
		this.recipient = recipient;
		this.defaultAddress = defaultAddress;
	}

	public ParsedAddress() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRecipient() {
        return recipient;
    }

    public void setRecipient(String recipient) {
        this.recipient = recipient;
    }

    public boolean isDefaultAddress() {
        return defaultAddress;
    }

    public void setDefaultAddress(boolean defaultAddress) {
        this.defaultAddress = defaultAddress;
    }
}
