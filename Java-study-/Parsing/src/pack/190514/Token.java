package pack;

public class Token {
	private TokenType type;
	private String value;
	
	public Token() {
		super();
	}
	public Token(TokenType type, String value) {
		super();
		this.type = type;
		this.value = value;
	}
	
	public TokenType getType() {
		return type;
	}
	public String getValue() {
		return value;
	}
}