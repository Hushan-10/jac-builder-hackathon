import from "@jac/runtime" { Link }

# Dedicated Experiences page (independent from homepage)

def:pub page() -> JsxElement {
    has selectedCategory: str = "All";
    has searchQuery: str = "";
    has appliedSearch: str = "";

    # Single source of truth (exactly 6)
    experiences = [
        {
            "id": "zermatt-matterhorn-day-tour",
            "title": "Zermatt Matterhorn Guided Day Tour",
            "location": "Zermatt",
            "categories": ["Mountain Tours", "Adventure"],
            "duration": "8 hours",
            "rating": 4.9,
            "reviews": 342,
            "price": 189,
            "description": "A full-day guided adventure with iconic Matterhorn views and alpine highlights.",
            "image": "https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=1600&q=80"
        },
        {
            "id": "interlaken-adventure-pass",
            "title": "Interlaken Adventure Pass",
            "location": "Interlaken",
            "categories": ["Adventure"],
            "duration": "Full day",
            "rating": 4.8,
            "reviews": 518,
            "price": 249,
            "description": "Choose your thrills — canyon swings, paragliding, and more in Switzerland’s adventure capital.",
            "image": "https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=1600&q=80"
        },
        {
            "id": "lucerne-lake-cruise",
            "title": "Lucerne Lake Cruise Experience",
            "location": "Lucerne",
            "categories": ["Lake Cruises", "Luxury"],
            "duration": "4 hours",
            "rating": 4.7,
            "reviews": 423,
            "price": 89,
            "description": "Glide across Lake Lucerne with panoramic views, premium comfort, and lakeside charm.",
            "image": "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1600&q=80"
        },
        {
            "id": "glacier-express-scenic-journey",
            "title": "Glacier Express Scenic Journey",
            "location": "Zermatt – St. Moritz",
            "categories": ["Scenic Trains", "Luxury"],
            "duration": "8 hours",
            "rating": 4.9,
            "reviews": 687,
            "price": 329,
            "description": "A legendary rail journey through dramatic valleys, viaducts, and snow-dusted peaks.",
            "image": "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=1600&q=80"
        },
        {
            "id": "st-moritz-wellness-retreat",
            "title": "St. Moritz Luxury Wellness Retreat",
            "location": "St. Moritz",
            "categories": ["Wellness", "Luxury"],
            "duration": "2 days",
            "rating": 4.9,
            "reviews": 156,
            "price": 890,
            "description": "Reset in the Alps with spa rituals, serene views, and curated wellness experiences.",
            "image": "https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&w=1600&q=80"
        },
        {
            "id": "grindelwald-luxury-chalet-stay",
            "title": "Swiss Mountain Luxury Chalet Stay",
            "location": "Grindelwald",
            "categories": ["Luxury", "Mountain Tours"],
            "duration": "3 days",
            "rating": 4.9,
            "reviews": 94,
            "price": 1490,
            "description": "A private chalet escape with premium service, alpine views, and refined comfort.",
            "image": "https://images.unsplash.com/photo-1482192596544-9eb780fc7f66?auto=format&fit=crop&w=1600&q=80"
        }
    ];

    tabs = [
        {"key": "All", "label": "All (6)"},
        {"key": "Mountain Tours", "label": "Mountain Tours"},
        {"key": "Adventure", "label": "Adventure"},
        {"key": "Lake Cruises", "label": "Lake Cruises"},
        {"key": "Scenic Trains", "label": "Scenic Trains"},
        {"key": "Wellness", "label": "Wellness"},
        {"key": "Luxury", "label": "Luxury"}
    ];

    def tab_click(e: any) -> None {
        k = (e.target and e.target.dataset and e.target.dataset.key) or "All";
        selectedCategory = str(k);
    }

    def on_query(e: any) -> None { searchQuery = e.target.value; }

    def apply_search(e: any = None) -> None {
        if e { e.preventDefault(); }
        appliedSearch = searchQuery;
    }

    def on_query_keydown(e: any) -> None {
        if (e and e.key) and (str(e.key).strip().lower() == "enter") {
            apply_search(e);
        }
    }

    q = str(appliedSearch or "").strip().lower();
    q_words = [w for w in q.split(" ") if w];

    def category_match(x: dict) -> bool {
        if selectedCategory == "All" { return True; }
        cats = x["categories"] or [];
        return any([
            str(c).strip().lower() == str(selectedCategory).strip().lower()
            for c in cats
        ]);
    }

    def search_match(x: dict) -> bool {
        if not q { return True; }
        title = str(x["title"] or "").lower();
        location = str(x["location"] or "").lower();
        description = str(x["description"] or "").lower();
        cats = x["categories"] or [];
        cats_text = " ".join([str(c) for c in cats]).lower();
        hay = (title + " " + location + " " + description + " " + cats_text);
        return all([hay.includes(w) for w in q_words]);
    }

    filtered = [x for x in experiences if x and category_match(x) and search_match(x)];

    count = len(filtered);
    results_text = "Showing " + str(count) + (" experience" if count == 1 else " experiences");

    def pill_class(is_active: bool) -> str {
        return (
            "shrink-0 inline-flex items-center justify-center rounded-full px-4 py-2 text-sm font-medium border transition-colors "
            + (
                "bg-[#0B2A4A] text-white border-[#0B2A4A]"
                    if is_active
                    else "bg-[#F2F4F7] text-[#344054] border-[#EAECF0] hover:bg-[#E9EEF5]"
            )
        );
    }

    def badge_class() -> str {
        return "inline-flex items-center rounded-full bg-white/90 text-[#0B2A4A] px-3 py-1 text-xs font-semibold";
    }

    def render_card(x: dict) -> JsxElement {
        cats = x["categories"] or [];
        return (
            <div className="group bg-white rounded-3xl border border-black/5 shadow-[0_18px_50px_rgba(16,24,40,0.10)] overflow-hidden">
                <div className="relative">
                    <img
                        src={x["image"]}
                        alt={x["title"]}
                        className="h-56 w-full object-cover"
                    />
                    <div className="absolute inset-0 bg-gradient-to-t from-black/35 via-black/0 to-black/0" />
                    <button
                        type="button"
                        className="absolute top-4 right-4 h-10 w-10 rounded-full bg-white/90 border border-black/10 grid place-items-center text-[#0B2A4A] hover:bg-white transition-colors"
                        aria-label="Add to wishlist"
                    >
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M20.8 4.6c-1.6-1.6-4.2-1.6-5.8 0L12 7.6 9 4.6c-1.6-1.6-4.2-1.6-5.8 0-1.6 1.6-1.6 4.2 0 5.8l2.9 2.9L12 19.2l5.9-5.9 2.9-2.9c1.6-1.6 1.6-4.2 0-5.8z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                        </svg>
                    </button>
                    <div className="absolute left-4 bottom-4 flex flex-wrap gap-2">
                        {[<span className={badge_class()}>{c}</span> for c in cats]}
                    </div>
                </div>

                <div className="p-6">
                    <div className="flex items-center justify-between text-sm text-[#667085]">
                        <div className="inline-flex items-center gap-2">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" className="text-[#98A2B3]">
                                <path d="M12 21s-7-4.4-7-11a7 7 0 1 1 14 0c0 6.6-7 11-7 11z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                                <circle cx="12" cy="10" r="2.5" stroke="currentColor" strokeWidth="2"/>
                            </svg>
                            <span>{x["location"]}</span>
                        </div>
                        <div className="inline-flex items-center gap-2">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" className="text-[#98A2B3]">
                                <path d="M12 6v6l4 2" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                                <circle cx="12" cy="12" r="9" stroke="currentColor" strokeWidth="2"/>
                            </svg>
                            <span>{x["duration"]}</span>
                        </div>
                    </div>

                    <h3 className="mt-4 text-2xl leading-8 text-[#101828] tracking-[-0.02em]" style={{"fontFamily": "ui-serif, Georgia, Cambria, 'Times New Roman', Times, serif"}}>
                        {x["title"]}
                    </h3>
                    <p className="mt-2 text-sm leading-6 text-[#475467]">{x["description"]}</p>

                    <div className="mt-5 flex items-center justify-between">
                        <div className="inline-flex items-center gap-2 text-sm text-[#344054]">
                            <div className="inline-flex items-center gap-1">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" className="text-[#F2B84B]">
                                    <path d="M12 17.3l-5.5 3 1-6.2-4.5-4.4 6.2-1 2.8-5.7 2.8 5.7 6.2 1-4.5 4.4 1 6.2-5.5-3z" fill="currentColor"/>
                                </svg>
                                <span className="font-semibold">{str(x["rating"])}</span>
                            </div>
                            <span className="text-[#667085]">({str(x["reviews"])})</span>
                        </div>
                        <div className="text-right">
                            <div className="text-xs uppercase tracking-[0.14em] text-[#98A2B3]">From</div>
                            <div className="text-lg font-semibold text-[#0B2A4A]">{"CHF " + str(x["price"])}</div>
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-white">
            <div className="sticky top-0 z-20 bg-white/90 backdrop-blur border-b border-black/5">
                <div className="max-w-6xl mx-auto px-4">
                    <div className="h-20 flex items-center justify-between">
                        <Link to="/" className="flex items-center gap-2 text-[#0B2A4A] no-underline">
                            <div className="h-9 w-9 rounded-xl bg-[#0B2A4A]/10 grid place-items-center">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" className="text-[#B88A2E]">
                                    <path d="M3 20l9-16 9 16H3z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round"/>
                                </svg>
                            </div>
                            <span className="text-xl font-semibold" style={{"fontFamily": "ui-serif, Georgia, Cambria, 'Times New Roman', Times, serif"}}>
                                SwissEscape
                            </span>
                        </Link>

                        <div className="hidden md:flex items-center gap-8 text-sm font-medium text-[#344054]">
                            <Link to="/destinations" className="hover:text-[#0B2A4A] transition-colors">Destinations</Link>
                            <Link to="/experiences" className="text-[#0B2A4A]">Experiences</Link>
                            <Link to="/" className="hover:text-[#0B2A4A] transition-colors">Stays</Link>
                            <Link to="/dashboard" className="hover:text-[#0B2A4A] transition-colors">Dashboard</Link>
                        </div>

                        <div className="flex items-center gap-3">
                            <Link to="/login" className="text-sm font-medium text-[#344054] hover:text-[#0B2A4A] transition-colors">Sign In</Link>
                            <Link
                                to="/login"
                                className="inline-flex items-center justify-center rounded-full px-5 py-2.5 text-sm font-semibold bg-[#B88A2E] text-white shadow-[0_10px_24px_rgba(184,138,46,0.25)] hover:opacity-95 transition-opacity"
                            >
                                Get Started
                            </Link>
                        </div>
                    </div>
                </div>
            </div>

            <div className="bg-[#0B2A4A]">
                <div className="max-w-6xl mx-auto px-4">
                    <div className="py-20 md:py-24 text-center">
                        <div className="text-xs font-semibold tracking-[0.22em] text-[#F2B84B]">SWISS EXPERIENCES</div>
                        <h1 className="mt-5 text-5xl md:text-6xl text-white tracking-[-0.02em]" style={{"fontFamily": "ui-serif, Georgia, Cambria, 'Times New Roman', Times, serif"}}>
                            Unforgettable Adventures
                        </h1>
                        <p className="mt-5 text-base md:text-lg max-w-2xl mx-auto" style={{"color": "rgba(255,255,255,0.78)"}}>
                            Browse curated tours, activities, and local experiences across Switzerland.
                        </p>

                        <div className="mt-10 flex items-center justify-center">
                            <div className="w-full max-w-2xl">
                                <div className="flex items-center gap-3">
                                    <div className="relative flex-1">
                                        <svg className="absolute left-4 top-1/2 -translate-y-1/2 h-5 w-5" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "rgba(255,255,255,0.55)"}}>
                                            <path d="M21 21l-4.3-4.3" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/>
                                            <circle cx="11" cy="11" r="7" stroke="currentColor" strokeWidth="2"/>
                                        </svg>
                                        <input
                                            value={searchQuery}
                                            onChange={on_query}
                                            onKeyDown={on_query_keydown}
                                            placeholder="Search experiences..."
                                            className="w-full h-14 rounded-2xl pl-12 pr-4 text-sm outline-none border border-white/10 bg-white/10 text-white placeholder:text-white/55 focus:border-white/25 focus:ring-[3px] focus:ring-white/10"
                                        />
                                    </div>
                                    <button
                                        type="button"
                                        onClick={apply_search}
                                        className="h-14 w-14 rounded-2xl bg-white text-[#0B2A4A] border border-white/10 shadow-[0_18px_40px_rgba(0,0,0,0.18)] hover:bg-white/95 transition-colors grid place-items-center"
                                        aria-label="Search"
                                    >
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M21 21l-4.3-4.3" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/>
                                            <circle cx="11" cy="11" r="7" stroke="currentColor" strokeWidth="2"/>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div className="bg-white">
                <div className="max-w-6xl mx-auto px-4">
                    <div className="-mt-7 pb-2">
                        <div className="bg-white rounded-3xl border border-black/5 shadow-[0_18px_50px_rgba(16,24,40,0.10)] px-4 py-4">
                            <div className="flex items-center gap-3 overflow-x-auto whitespace-nowrap pb-1">
                                {[
                                    <button
                                        type="button"
                                        data-key={t["key"]}
                                        className={pill_class(t["key"] == selectedCategory)}
                                        onClick={tab_click}
                                    >
                                        {t["label"]}
                                    </button>
                                    for t in tabs
                                ]}
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div className="bg-[#F8FAFC]">
                <div className="max-w-6xl mx-auto px-4 py-12">
                    <div className="flex items-center justify-between gap-4">
                        <div className="text-sm text-[#667085]">{results_text}</div>
                        <div className="text-xs text-[#98A2B3]">{("Filtered by: " + selectedCategory) if selectedCategory != "All" else ""}</div>
                    </div>

                    <div className="mt-6 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        {[render_card(x) for x in filtered]}
                    </div>

                    {(count == 0)
                    and (
                        <div className="mt-10 bg-white rounded-3xl border border-black/5 shadow-[0_18px_50px_rgba(16,24,40,0.10)] p-10 text-center">
                            <div className="text-lg text-[#101828]" style={{"fontFamily": "ui-serif, Georgia, Cambria, 'Times New Roman', Times, serif"}}>
                                No experiences found
                            </div>
                            <div className="mt-2 text-sm text-[#667085]">Try a different search or category.</div>
                        </div>
                    )}
                </div>
            </div>

            <footer className="bg-[#0B2A4A] text-white">
                <div className="max-w-6xl mx-auto px-4 py-14">
                    <div className="grid grid-cols-1 md:grid-cols-4 gap-10">
                        <div>
                            <div className="flex items-center gap-2">
                                <div className="h-9 w-9 rounded-xl bg-white/10 grid place-items-center">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" className="text-[#F2B84B]">
                                        <path d="M3 20l9-16 9 16H3z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round"/>
                                    </svg>
                                </div>
                                <span className="text-lg font-semibold" style={{"fontFamily": "ui-serif, Georgia, Cambria, 'Times New Roman', Times, serif"}}>
                                    SwissEscape
                                </span>
                            </div>
                            <p className="mt-4 text-sm" style={{"color": "rgba(255,255,255,0.78)"}}>
                                Premium journeys across Switzerland — curated stays, destinations, and unforgettable experiences.
                            </p>
                        </div>

                        <div>
                            <div className="text-sm font-semibold">Explore</div>
                            <div className="mt-4 flex flex-col gap-2">
                                <Link to="/destinations" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>
                                    Destinations
                                </Link>
                                <Link to="/experiences" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>
                                    Experiences
                                </Link>
                                <Link to="/" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>
                                    Stays
                                </Link>
                            </div>
                        </div>

                        <div>
                            <div className="text-sm font-semibold">Company</div>
                            <div className="mt-4 flex flex-col gap-2">
                                <Link to="/" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>
                                    About
                                </Link>
                                <Link to="/" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>
                                    Contact
                                </Link>
                                <Link to="/" className="text-sm hover:text-white transition-colors" style={{"color": "rgba(255,255,255,0.78)"}}>
                                    Privacy
                                </Link>
                            </div>
                        </div>

                        <div>
                            <div className="text-sm font-semibold">Get updates</div>
                            <p className="mt-4 text-sm" style={{"color": "rgba(255,255,255,0.78)"}}>
                                Monthly inspiration, new routes, and premium offers.
                            </p>
                            <div className="mt-4 flex items-center gap-2">
                                <input
                                    className="h-11 w-full rounded-2xl px-4 text-sm outline-none border border-white/10 bg-white/10 text-white placeholder:text-white/55 focus:border-white/25 focus:ring-[3px] focus:ring-white/10"
                                    placeholder="Email address"
                                />
                                <button
                                    type="button"
                                    className="h-11 px-4 rounded-2xl bg-[#B88A2E] text-white text-sm font-semibold hover:opacity-95 transition-opacity"
                                >
                                    Join
                                </button>
                            </div>
                        </div>
                    </div>

                    <div className="mt-12 pt-8 border-t border-white/10 flex flex-col md:flex-row items-center justify-between gap-4">
                        <div className="text-xs" style={{"color": "rgba(255,255,255,0.65)"}}>
                            © {"2026"} SwissEscape. All rights reserved.
                        </div>
                        <div className="text-xs" style={{"color": "rgba(255,255,255,0.65)"}}>
                            Crafted for premium Swiss travel.
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    );
}
