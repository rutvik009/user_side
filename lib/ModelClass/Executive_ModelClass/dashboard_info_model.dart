class DashboardInfoModel {
	bool? success;
	Data? data;

	DashboardInfoModel({this.success, this.data});

	DashboardInfoModel.fromJson(Map<String, dynamic> json) {
		success = json['success'];
		data = json['data'] != null ? new Data.fromJson(json['data']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = this.success;
		if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
		return data;
	}
}

class Data {
	Marrage? marrage;
	Revenue? revenue;
	WithdrawProposal? withdrawProposal;
	List<Review>? review;
	int? profileComplete;
	int? rating;

	Data({this.marrage, this.revenue, this.withdrawProposal, this.review, this.profileComplete, this.rating});

	Data.fromJson(Map<String, dynamic> json) {
		marrage = json['marrage'] != null ? new Marrage.fromJson(json['marrage']) : null;
		revenue = json['revenue'] != null ? new Revenue.fromJson(json['revenue']) : null;
		withdrawProposal = json['withdraw_proposal'] != null ? new WithdrawProposal.fromJson(json['withdraw_proposal']) : null;
		if (json['review'] != null) {
			review = <Review>[];
			json['review'].forEach((v) { review!.add(new Review.fromJson(v)); });
		}
		profileComplete = json['profile_complete'];
		rating = json['rating'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.marrage != null) {
      data['marrage'] = this.marrage!.toJson();
    }
		if (this.revenue != null) {
      data['revenue'] = this.revenue!.toJson();
    }
		if (this.withdrawProposal != null) {
      data['withdraw_proposal'] = this.withdrawProposal!.toJson();
    }
		if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
		data['profile_complete'] = this.profileComplete;
		data['rating'] = this.rating;
		return data;
	}
}

class Marrage {
	int? inProgress;
	int? finalProposal;
	int? completed;

	Marrage({this.inProgress, this.finalProposal, this.completed});

	Marrage.fromJson(Map<String, dynamic> json) {
		inProgress = json['in_progress'];
		finalProposal = json['final'];
		completed = json['completed'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['in_progress'] = this.inProgress;
		data['final'] = this.finalProposal;
		data['completed'] = this.completed;
		return data;
	}
}

class Revenue {
	int? monthly;
	int? monthlyMarrageCount;
	int? yearly;
	int? yearlyMarrageCount;

	Revenue({this.monthly, this.monthlyMarrageCount, this.yearly, this.yearlyMarrageCount});

	Revenue.fromJson(Map<String, dynamic> json) {
		monthly = json['monthly'];
		monthlyMarrageCount = json['monthly_marrage_count'];
		yearly = json['yearly'];
		yearlyMarrageCount = json['yearly_marrage_count'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['monthly'] = this.monthly;
		data['monthly_marrage_count'] = this.monthlyMarrageCount;
		data['yearly'] = this.yearly;
		data['yearly_marrage_count'] = this.yearlyMarrageCount;
		return data;
	}
}

class WithdrawProposal {
	int? currentMonth;
	int? currentMonthMarrageCount;
	int? previousMonth;
	int? previousMonthMarrageCount;
	int? yearly;
	int? yearlyMarrageCount;

	WithdrawProposal({this.currentMonth, this.currentMonthMarrageCount, this.previousMonth, this.previousMonthMarrageCount, this.yearly, this.yearlyMarrageCount});

	WithdrawProposal.fromJson(Map<String, dynamic> json) {
		currentMonth = json['current_month'];
		currentMonthMarrageCount = json['current_month_marrage_count'];
		previousMonth = json['previous_month'];
		previousMonthMarrageCount = json['previous_month_marrage_count'];
		yearly = json['yearly'];
		yearlyMarrageCount = json['yearly_marrage_count'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['current_month'] = this.currentMonth;
		data['current_month_marrage_count'] = this.currentMonthMarrageCount;
		data['previous_month'] = this.previousMonth;
		data['previous_month_marrage_count'] = this.previousMonthMarrageCount;
		data['yearly'] = this.yearly;
		data['yearly_marrage_count'] = this.yearlyMarrageCount;
		return data;
	}
}

class Review {
	String? username;
	String? profileImage;
	String? email;
	var rating;
	String? comment;

	Review({this.username, this.profileImage, this.email, this.rating, this.comment});

	Review.fromJson(Map<String, dynamic> json) {
		username = json['username'];
		profileImage = json['profileImage'];
		email = json['email'];
		rating = json['rating'];
		comment = json['comment'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['username'] = this.username;
		data['profileImage'] = this.profileImage;
		data['email'] = this.email;
		data['rating'] = this.rating;
		data['comment'] = this.comment;
		return data;
	}
}
