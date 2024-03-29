import { StyleSheet, Text, View, Image, Button } from "react-native";
import { expandComponent, getProps } from "./utils";

const TestComponent = (props) => {
	console.log(props);
	return (
		<View style={styles.container}>
			<Text>TestComponent</Text>
		</View>
	);
};

const styles = StyleSheet.create({
	container: {
		flex: 1,
		// position: 'absolute',
		flexWrap: "wrap",
		zIndex: 100,
		// flexShrink: 1,
		backgroundColor: "#b58900",
		alignItems: "center",
		justifyContent: "center",
	},
});
export default {
	id: "TestComponent",
	apis: [{ desk: "dimension", id: "dimension-0.0.1" }],
	component: TestComponent,
};
