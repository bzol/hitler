import { ScrollView, StyleSheet, Text, View } from "react-native";
import TestComponent from './cosmos/components/TestComponent';
import {} from './cosmos/declare';

export default function App() {
		return (
			<View style={styles.container}>
				<TestComponent.component/>
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
