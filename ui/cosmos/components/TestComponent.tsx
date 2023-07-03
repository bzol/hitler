import { StyleSheet, Text, View, Image, Button } from "react-native";
import { expandComponent, getProps } from '../utils';

const TestComponent = (props) => {
	// const api1 = getProps('api1-0.0.1', props);
	// const api2 = getProps('api2-0.0.1', props);
	console.log(props.api1);
	return (
		<View 
			style={styles.container}
		>
			<Text>{props.api1}</Text>
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
	apis: [{ desk: "diemnsion", id: "dimension-0.0.1" }],
	component: TestComponent,
};
