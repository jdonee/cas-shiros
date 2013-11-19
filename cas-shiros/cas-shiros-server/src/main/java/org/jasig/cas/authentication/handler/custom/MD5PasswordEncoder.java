package org.jasig.cas.authentication.handler.custom;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.validation.constraints.NotNull;

import org.jasig.cas.authentication.handler.PasswordEncoder;
import org.springframework.util.StringUtils;

/**
 * 
 * 根据实际情况调整的加密方式
 * 
 * @author ZengAihui
 * @since 1.0.0
 * 
 */
public final class MD5PasswordEncoder implements PasswordEncoder {

	private static final char HEX_DIGITS[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D',
			'E', 'F' };

	@NotNull
	private final String encodingAlgorithm;

	private String characterEncoding;

	public MD5PasswordEncoder(final String encodingAlgorithm) {
		this.encodingAlgorithm = encodingAlgorithm;
	}

	@Override
	public String encode(final String password) {
		if (password == null) {
			return null;
		}

		try {
			MessageDigest messageDigest = MessageDigest.getInstance(this.encodingAlgorithm);

			if (StringUtils.hasText(this.characterEncoding)) {
				messageDigest.update(password.getBytes(this.characterEncoding));
			} else {
				messageDigest.update(password.getBytes());
			}

			final byte[] digest = messageDigest.digest();

			return getFormattedText(digest);
		} catch (final NoSuchAlgorithmException e) {
			throw new SecurityException(e);
		} catch (final UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Takes the raw bytes from the digest and formats them correct.
	 * 
	 * @param bytes the raw bytes from the digest.
	 * @return the formatted bytes.
	 */
	private String getFormattedText(byte[] bytes) {
		final StringBuilder buf = new StringBuilder(bytes.length * 2);

		for (byte b : bytes) {
			buf.append(HEX_DIGITS[(b >> 4) & 0x0f]);
			buf.append(HEX_DIGITS[b & 0x0f]);
		}
		return buf.toString();
	}

	public final void setCharacterEncoding(final String characterEncoding) {
		this.characterEncoding = characterEncoding;
	}

}
