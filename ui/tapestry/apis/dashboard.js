const dashboard = {
	id: "dashboard-0.0.1",
	endpoints: [
		{
			id: "pSync",
			type: 'poke',
			mark: "dashboard-action",
		},
		{
			id: "sDashboards",
			type: 'scry',
			path: "/dashboards",
		},
	],
};

export default dashboard;
