//go:build !boringcrypto

package options

// Not using as this will always be false as we are not getting value in webhook configuration.
//func InsecureSkipVerify(insecureSkipVerify bool) bool {
//	return insecureSkipVerify
//}

func GetTlsMaxVersion() string {
	return "VersionTLS13"
}
