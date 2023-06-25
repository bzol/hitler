import { ScrollView, StyleSheet, Text, View } from "react-native";
import { windowWidth, windowHeight } from "./src/constants";

export default function App() {
		return (
			<View style={styles.container}>
				<Text>...Loading</Text>
			</View>
		);
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		position: "absolute",
		width: windowWidth,
		height: windowHeight,
		// zIndex: 0,
		// backgroundColor: "#fff",
		// alignItems: "center",
		// justifyContent: "center",
	},
});

console.log('Hitler Fetched');
