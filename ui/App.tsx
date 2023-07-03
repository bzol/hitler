import { ScrollView, StyleSheet, Text, View } from "react-native";

export default function App() {
		return (
			<View style={styles.container}>
				<Text> Hello </Text>
			</View>
		);
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		position: "absolute",
		// zIndex: 0,
		// backgroundColor: "#fff",
		// alignItems: "center",
		// justifyContent: "center",
	},
});
