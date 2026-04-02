import from "@jac/runtime" { Link, useNavigate }

# Child components to avoid dynamic dict values as JSX text children

def:pub DestCard(props: dict) -> JsxElement {
    name = props.name or "";
    tag = props.tag or "";
    img = props.img or "";
    to = props.to or "/destinations";

    return (
        <Link
            to={to}
            className="group relative overflow-hidden rounded-[var(--radius-xl)] border border-border shadow-soft hover:shadow-card transition-[box-shadow,transform] duration-300 hover:-translate-y-0.5"
        >
            <div
                className="absolute inset-0"
                style={{"backgroundImage": "url(" + img + ")", "backgroundSize": "cover", "backgroundPosition": "center"}}
            />
            <div className="absolute inset-0 bg-gradient-to-t from-black/55 via-black/10 to-black/0" />
            <div className="relative p-5 min-h-[220px] flex flex-col justify-end">
                <div className="text-white/90 text-xs uppercase tracking-[0.18em]"><span>{tag}</span></div>
                <div className="mt-2 text-white text-xl font-semibold"><span>{name}</span></div>
                <div className="mt-3 inline-flex items-center gap-2 text-sm text-white/85">
                    <span className="h-1.5 w-1.5 rounded-full" style={{"backgroundColor": "var(--color-gold)"}} />
                    <span>Curated experiences</span>
                </div>
            </div>
        </Link>
    );
}


def:pub ExperienceCard(props: dict) -> JsxElement {
    title = props.title or "";
    loc = props.loc or "";
    dur = props.dur or "";
    price = props.price or "";
    cat = props.cat or "";
    img = props.img or "";
    rating = props.rating or 0;
    reviews = props.reviews or 0;

    return (
        <div className="se-glass rounded-[var(--radius-xl)] overflow-hidden">
            <div className="h-44 md:h-48 bg-cover bg-center" style={{"backgroundImage": "url(" + img + ")"}} />
            <div className="p-5">
                <div className="flex items-center justify-between gap-4">
                    <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">
                        <span>{cat}</span>
                        <span>{" • " + dur}</span>
                    </div>
                    <div className="text-sm font-semibold" style={{"color": "var(--color-gold)"}}><span>{price}</span></div>
                </div>
                <div className="mt-2 text-lg font-semibold text-foreground"><span>{title}</span></div>
                <div className="mt-1 text-sm text-muted-foreground"><span>{loc}</span></div>
                <div className="mt-4 flex items-center justify-between gap-3">
                    <div className="text-sm text-foreground/80">
                        <span className="font-semibold">{str(rating)}</span>
                        <span className="text-muted-foreground">{" / 5 • " + str(reviews) + " reviews"}</span>
                    </div>
                    <div className="flex gap-2">
                        <Link to="/experiences" className="h-10 px-4 inline-flex items-center justify-center rounded-xl border border-border bg-white/60 text-sm font-medium hover:bg-white/80 transition-colors">
                            View
                        </Link>
                        <Link to="/experiences" className="h-10 px-4 inline-flex items-center justify-center rounded-xl bg-primary text-primary-foreground text-sm font-medium border border-primary hover:opacity-95 transition-opacity">
                            Book
                        </Link>
                    </div>
                </div>
            </div>
        </div>
    );
}


def:pub CategoryCard(props: dict) -> JsxElement {
    name = props.name or "";
    desc = props.desc or "";
    icon = props.icon or "";

    return (
        <Link to="/experiences" className="group rounded-[var(--radius-lg)] border border-border bg-white/55 hover:bg-white/75 transition-colors p-5">
            <div className="flex items-start justify-between gap-4">
                <div>
                    <div className="text-lg font-semibold"><span>{name}</span></div>
                    <div className="mt-1 text-sm text-muted-foreground leading-relaxed"><span>{desc}</span></div>
                </div>
                <div className="h-10 w-10 rounded-2xl flex items-center justify-center border border-border bg-white/70 text-lg"><span>{icon}</span></div>
            </div>
            <div className="mt-4 text-sm font-medium text-primary inline-flex items-center gap-2">
                <span>Browse</span>
                <span className="group-hover:translate-x-0.5 transition-transform">→</span>
            </div>
        </Link>
    );
}


def:pub TestimonialCard(props: dict) -> JsxElement {
    quote = props.quote or "";
    name = props.name or "";
    meta = props.meta or "";

    return (
        <div className="rounded-[var(--radius-lg)] border border-border bg-white/55 p-5">
            <div className="text-sm leading-relaxed text-foreground/90"><span>{"“" + quote + "”"}</span></div>
            <div className="mt-3 text-xs uppercase tracking-[0.16em] text-muted-foreground"><span>{name}</span></div>
            <div className="mt-1 text-xs text-muted-foreground"><span>{meta}</span></div>
        </div>
    );
}


def:pub page() -> JsxElement {
    hero_img: str = "https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=2400&q=80";

    has destination: str = "";
    has exp_type: str = "";
    has dates: str = "";
    has group_size: str = "";
    has budget: str = "";

    navigate = useNavigate();

    def on_submit(e: any) -> None {
        e.preventDefault();
        navigate("/experiences");
    }

    def on_destination(e: any) -> None { destination = e.target.value; }
    def on_type(e: any) -> None { exp_type = e.target.value; }
    def on_dates(e: any) -> None { dates = e.target.value; }
    def on_group(e: any) -> None { group_size = e.target.value; }
    def on_budget(e: any) -> None { budget = e.target.value; }

    featured_destinations = [
        {"name": "Zermatt", "tag": "Matterhorn", "img": "https://images.unsplash.com/photo-1526481280695-3c687fd643ed?auto=format&fit=crop&w=1600&q=80"},
        {"name": "Interlaken", "tag": "Lakes & peaks", "img": "https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1600&q=80"},
        {"name": "Lucerne", "tag": "Old town & lake", "img": "https://images.unsplash.com/photo-1548013146-72479768bada?auto=format&fit=crop&w=1600&q=80"},
        {"name": "St. Moritz", "tag": "Alpine luxury", "img": "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=1600&q=80"}
    ];

    popular = [
        {"title": "Zermatt Matterhorn Guided Day Tour", "loc": "Zermatt", "dur": "8h", "price": "CHF 290", "rating": 4.9, "reviews": 412, "img": "https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=1600&q=80", "cat": "Mountain"},
        {"title": "Glacier Express Scenic Journey", "loc": "St. Moritz → Zermatt", "dur": "1 day", "price": "CHF 189", "rating": 4.8, "reviews": 980, "img": "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=1600&q=80", "cat": "Train"},
        {"title": "Lucerne Lake Cruise Experience", "loc": "Lucerne", "dur": "2.5h", "price": "CHF 79", "rating": 4.7, "reviews": 633, "img": "https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=1600&q=80", "cat": "Cruise"},
        {"title": "Swiss Chocolate & Culture Tour", "loc": "Zurich", "dur": "3h", "price": "CHF 98", "rating": 4.9, "reviews": 521, "img": "https://images.unsplash.com/photo-1541592106381-b31e9677c0e5?auto=format&fit=crop&w=1600&q=80", "cat": "Food"}
    ];

    categories = [
        {"name": "Mountain Adventures", "desc": "Guided summits, glaciers, and panoramic ridgelines.", "icon": "⛰"},
        {"name": "Scenic Train Trips", "desc": "Cinematic routes through valleys and alpine passes.", "icon": "🚆"},
        {"name": "Lake Cruises", "desc": "Emerald waters, golden-hour decks, and quiet coves.", "icon": "🛥"},
        {"name": "Ski & Snow", "desc": "Powder days, private instructors, and chalet comfort.", "icon": "🎿"},
        {"name": "Food & Chocolate", "desc": "Tastings, ateliers, and Swiss culinary stories.", "icon": "🍫"},
        {"name": "Luxury Stays", "desc": "Boutique hotels, chalets, and lake-view resorts.", "icon": "✨"}
    ];

    testimonials = [
        {"name": "Amelia R.", "quote": "SwissEscape curated a flawless week — every transfer, every view, every detail felt effortless.", "meta": "London • Luxury / Romantic"},
        {"name": "Noah K.", "quote": "The local guide in Lauterbrunnen was incredible. We found hidden waterfalls and quiet trails.", "meta": "Toronto • Adventure"},
        {"name": "Sofia M.", "quote": "The Glacier Express day was pure cinema. The booking flow was smooth and premium.", "meta": "Barcelona • Cultural"}
    ];

    return (
        <div className="min-h-screen se-bg">
            <section className="relative min-h-[100svh] overflow-hidden">
                <div
                    className="absolute inset-0"
                    style={{
                        "backgroundImage": "linear-gradient(180deg, rgba(7,20,39,0.78) 0%, rgba(7,20,39,0.55) 35%, rgba(7,20,39,0.25) 70%, rgba(7,20,39,0.15) 100%), url(" + hero_img + ")",
                        "backgroundSize": "cover",
                        "backgroundPosition": "center"
                    }}
                />

                <div className="relative max-w-6xl mx-auto px-4 pt-6">
                    <nav className="flex items-center justify-between text-white/90">
                        <Link to="/" className="inline-flex items-center gap-3">
                            <div className="h-9 w-9 rounded-xl border border-white/20 bg-white/10 backdrop-blur flex items-center justify-center">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                    <path d="M3 19L12 5l9 14H3Z" stroke="currentColor" strokeWidth="2" strokeLinejoin="round" />
                                </svg>
                            </div>
                            <div className="text-xl" style={{"fontFamily": "var(--font-display)"}}>SwissEscape</div>
                        </Link>

                        <div className="hidden md:flex items-center gap-10 text-sm">
                            <Link to="/destinations" className="hover:text-white transition-colors">Destinations</Link>
                            <Link to="/experiences" className="hover:text-white transition-colors">Experiences</Link>
                            <Link to="/stays" className="hover:text-white transition-colors">Stays</Link>
                            <Link to="/itinerary" className="hover:text-white transition-colors">AI Planner</Link>
                        </div>

                        <div className="flex items-center gap-4">
                            <Link to="/login" className="text-sm hover:text-white transition-colors">Sign In</Link>
                            <Link
                                to="/signup"
                                className="h-10 px-5 inline-flex items-center justify-center rounded-full text-sm font-semibold shadow-soft"
                                style={{"backgroundColor": "var(--color-gold)", "color": "rgba(7,20,39,0.95)"}}
                            >
                                Get Started
                            </Link>
                        </div>
                    </nav>
                </div>

                <div className="relative max-w-6xl mx-auto px-4 pt-16 md:pt-24 pb-28 md:pb-36">
                    <div className="text-center">
                        <div className="text-xs uppercase tracking-[0.28em]" style={{"color": "var(--color-gold)"}}>
                            PREMIUM SWISS TRAVEL MARKETPLACE
                        </div>
                        <h1 className="mt-6 text-white leading-[0.98] tracking-[-0.02em] text-5xl md:text-7xl lg:text-8xl" style={{"fontFamily": "var(--font-display)"}}>
                            Discover the Magic of
                            <span className="block" style={{"color": "var(--color-gold)"}}>Switzerland</span>
                        </h1>
                        <p className="mt-6 max-w-3xl mx-auto text-white/85 text-base md:text-lg leading-relaxed">
                            Curated local experiences, scenic journeys, and luxury stays across the Swiss Alps — crafted by locals, loved by travelers.
                        </p>
                    </div>

                    <div className="mt-12 md:mt-14 relative">
                        <div className="mx-auto max-w-5xl">
                            <form
                                onSubmit={on_submit}
                                className="se-glass rounded-full shadow-card border border-white/15 bg-white/70 backdrop-blur px-4 py-3 md:px-6 md:py-4"
                            >
                                <div className="grid grid-cols-1 md:grid-cols-12 gap-3 md:gap-4 items-center">
                                    <div className="md:col-span-3">
                                        <div className="flex items-center gap-3 rounded-full bg-white/60 border border-border px-4 h-12">
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                                <path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 1 1 18 0Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                                <path d="M12 10a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                            </svg>
                                            <input value={destination} onChange={on_destination} placeholder="Where to?" className="w-full bg-transparent text-sm outline-none placeholder:text-muted-foreground" />
                                        </div>
                                    </div>

                                    <div className="md:col-span-3">
                                        <div className="flex items-center gap-3 rounded-full bg-white/60 border border-border px-4 h-12">
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                                <circle cx="11" cy="11" r="7" stroke="currentColor" strokeWidth="2" />
                                                <path d="M20 20l-3.5-3.5" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                            </svg>
                                            <input value={exp_type} onChange={on_type} placeholder="Experience type" className="w-full bg-transparent text-sm outline-none placeholder:text-muted-foreground" />
                                        </div>
                                    </div>

                                    <div className="md:col-span-3">
                                        <div className="flex items-center gap-3 rounded-full bg-white/60 border border-border px-4 h-12">
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                                <rect x="3" y="4" width="18" height="18" rx="2" stroke="currentColor" strokeWidth="2" />
                                                <path d="M16 2v4M8 2v4M3 10h18" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                            </svg>
                                            <input value={dates} onChange={on_dates} placeholder="Travel dates" className="w-full bg-transparent text-sm outline-none placeholder:text-muted-foreground" />
                                        </div>
                                    </div>

                                    <div className="md:col-span-2">
                                        <div className="flex items-center gap-3 rounded-full bg-white/60 border border-border px-4 h-12">
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                                <circle cx="12" cy="7" r="4" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                            </svg>
                                            <input value={group_size} onChange={on_group} placeholder="Guests" className="w-full bg-transparent text-sm outline-none placeholder:text-muted-foreground" />
                                        </div>
                                    </div>

                                    <div className="md:col-span-1 flex md:justify-end">
                                        <button
                                            type="submit"
                                            className="h-12 w-full md:w-12 rounded-full inline-flex items-center justify-center font-semibold shadow-soft"
                                            style={{"backgroundColor": "var(--color-gold)", "color": "rgba(7,20,39,0.95)"}}
                                            aria-label="Explore"
                                        >
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <circle cx="11" cy="11" r="7" stroke="currentColor" strokeWidth="2" />
                                                <path d="M20 20l-3.5-3.5" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div className="mt-10 md:mt-12 grid grid-cols-2 md:grid-cols-4 gap-8 text-center text-white/90">
                            <div>
                                <div className="text-2xl md:text-3xl font-semibold">200+</div>
                                <div className="mt-1 text-xs uppercase tracking-[0.18em] text-white/70">Curated Experiences</div>
                            </div>
                            <div>
                                <div className="text-2xl md:text-3xl font-semibold">50+</div>
                                <div className="mt-1 text-xs uppercase tracking-[0.18em] text-white/70">Local Guides</div>
                            </div>
                            <div>
                                <div className="text-2xl md:text-3xl font-semibold">10</div>
                                <div className="mt-1 text-xs uppercase tracking-[0.18em] text-white/70">Swiss Destinations</div>
                            </div>
                            <div>
                                <div className="text-2xl md:text-3xl font-semibold">4.8★</div>
                                <div className="mt-1 text-xs uppercase tracking-[0.18em] text-white/70">Average Rating</div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section className="max-w-6xl mx-auto px-4 py-14 md:py-20">
                <div className="text-center">
                    <div className="text-xs uppercase tracking-[0.28em]" style={{"color": "var(--color-gold)"}}>
                        EXPLORE SWITZERLAND
                    </div>
                    <h2 className="mt-4 text-4xl md:text-5xl leading-[1.05]" style={{"fontFamily": "var(--font-display)"}}>
                        Featured Destinations
                    </h2>
                    <p className="mt-4 text-sm md:text-base text-muted-foreground max-w-2xl mx-auto leading-relaxed">
                        From alpine peaks to lakeside towns, discover the most breathtaking places<br className="hidden md:block" />
                        in Switzerland.
                    </p>
                </div>

                <div className="mt-12 grid grid-cols-1 md:grid-cols-3 gap-7">
                    {[
                        <div key={d["name"]} className="group rounded-[var(--radius-xl)] bg-white/70 border border-border shadow-soft hover:shadow-card transition-[box-shadow,transform] duration-300 hover:-translate-y-1 overflow-hidden">
                            <Link to="/destinations" className="block">
                                <div className="relative overflow-hidden rounded-[var(--radius-xl)]">
                                    <div className="h-64 bg-cover bg-center transition-transform duration-500 group-hover:scale-[1.06]" style={{"backgroundImage": "url(" + d["img"] + ")"}} />
                                    <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-black/15 to-black/0" />

                                    <div className="absolute top-4 right-4">
                                        <div className="px-4 py-2 rounded-full text-xs font-semibold text-white shadow-soft" style={{"backgroundColor": "var(--color-gold)"}}>
                                            <span>{d["badge"]}</span>
                                        </div>
                                    </div>

                                    <div className="absolute left-5 bottom-5">
                                        <div className="text-white text-3xl leading-none" style={{"fontFamily": "var(--font-display)"}}><span>{d["name"]}</span></div>
                                        <div className="mt-1 text-white/85 text-sm"><span>{d["tagline"]}</span></div>
                                    </div>
                                </div>
                            </Link>

                            <div className="px-6 py-6">
                                <div className="flex items-center gap-2 text-sm text-muted-foreground">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style={{"color": "var(--color-gold)"}}>
                                        <path d="M12 22s8-4 8-10V6l-8-4-8 4v6c0 6 8 10 8 10Z" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                                    </svg>
                                    <span>{d["season"]}</span>
                                </div>
                                <p className="mt-3 text-sm text-muted-foreground leading-relaxed">
                                    {d["desc"]}
                                </p>
                                <Link to="/destinations" className="mt-4 inline-flex items-center gap-2 text-sm font-medium" style={{"color": "var(--color-gold)"}}>
                                    Explore
                                    <span className="transition-transform duration-200 group-hover:translate-x-0.5">→</span>
                                </Link>
                            </div>
                        </div>
                        for d in [
                            {
                                "name": "Zermatt",
                                "tagline": "Home of the Matterhorn",
                                "badge": "24 experiences",
                                "season": "Dec–Mar (Ski) / Jun–Sep (Hike)",
                                "desc": "A car-free alpine village at the foot of the iconic Matterhorn, offering world-class skiing, hiking, and cozy chalets.",
                                "img": "https://images.unsplash.com/photo-1521292270410-a8c4d716d518?auto=format&fit=crop&w=2400&q=80&crop=entropy"
                            },
                            {
                                "name": "Interlaken",
                                "tagline": "Adventure Capital of Switzerland",
                                "badge": "32 experiences",
                                "season": "Year-round",
                                "desc": "Nestled between Lake Thun and Lake Brienz, Interlaken is the gateway to the Jungfrau region and unforgettable mountain views.",
                                "img": "https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "name": "Lucerne",
                                "tagline": "The Heart of Switzerland",
                                "badge": "28 experiences",
                                "season": "Apr–Oct",
                                "desc": "A picturesque city on Lake Lucerne with a perfectly preserved medieval old town, iconic bridges, and lakeside promenades.",
                                "img": "https://images.unsplash.com/photo-1548013146-72479768bada?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "name": "Zurich",
                                "tagline": "Culture Meets Alpine Charm",
                                "badge": "22 experiences",
                                "season": "Year-round",
                                "desc": "Switzerland's largest city blends cosmopolitan culture, world-class dining, and lakefront living with easy access to alpine escapes.",
                                "img": "https://images.unsplash.com/photo-1528909514045-2fa4ac7a08ba?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "name": "Geneva",
                                "tagline": "The Swiss Riviera Gateway",
                                "badge": "18 experiences",
                                "season": "May–Oct",
                                "desc": "An international city on Lake Geneva surrounded by vineyards, offering cultural richness, luxury lakeside promenades, and mountain views.",
                                "img": "https://images.unsplash.com/photo-1506377247377-2a5b3b417ebb?auto=format&fit=crop&w=2400&q=80"
                            },
                            {
                                "name": "Grindelwald",
                                "tagline": "Village at the Foot of the Eiger",
                                "badge": "20 experiences",
                                "season": "Jun–Sep / Dec–Mar",
                                "desc": "A charming mountain village offering dramatic Eiger views, the First cliff walk, and access to iconic Jungfrau-region trails.",
                                "img": "https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=2400&q=80"
                            }
                        ]
                    ]}
                </div>
            </section>

            <section className="max-w-6xl mx-auto px-4 pb-12 md:pb-16">
                <div className="text-center">
                    <div className="text-xs uppercase tracking-[0.28em]" style={{"color": "var(--color-gold)"}}>
                        POPULAR EXPERIENCES
                    </div>
                    <h2 className="mt-4 text-4xl md:text-5xl leading-[1.05]" style={{"fontFamily": "var(--font-display)"}}>
                        Popular Experiences
                    </h2>
                    <p className="mt-4 text-sm md:text-base text-muted-foreground max-w-2xl mx-auto leading-relaxed">
                        Handpicked journeys with premium hosts, verified reviews, and seamless booking.
                    </p>
                </div>

                <div className="mt-12 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-7">
                    {[
                        <div key={x["title"]} className="group rounded-[var(--radius-xl)] bg-white/70 border border-border shadow-soft hover:shadow-card transition-[box-shadow,transform] duration-300 hover:-translate-y-1 overflow-hidden">
                            <Link to="/experiences" className="block">
                                <div className="relative overflow-hidden rounded-[var(--radius-xl)]">
                                    <div className="h-56 bg-cover bg-center transition-transform duration-500 group-hover:scale-[1.06]" style={{"backgroundImage": "url(" + x["img"] + ")"}} />
                                    <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-black/15 to-black/0" />
                                    <div className="absolute top-4 right-4">
                                        <div className="px-4 py-2 rounded-full text-xs font-semibold text-white shadow-soft" style={{"backgroundColor": "var(--color-gold)"}}>
                                            <span>{x["price"]}</span>
                                        </div>
                                    </div>
                                    <div className="absolute left-5 bottom-5">
                                        <div className="text-white text-2xl leading-none" style={{"fontFamily": "var(--font-display)"}}><span>{x["title"]}</span></div>
                                        <div className="mt-1 text-white/85 text-sm"><span>{x["loc"]}</span></div>
                                    </div>
                                </div>
                            </Link>

                            <div className="px-6 py-6">
                                <div className="flex items-center justify-between gap-4 text-sm text-muted-foreground">
                                    <div className="inline-flex items-center gap-2">
                                        <span className="h-1.5 w-1.5 rounded-full" style={{"backgroundColor": "var(--color-gold)"}} />
                                        <span>{x["rating"]}</span>
                                    </div>
                                    <div className="text-xs uppercase tracking-[0.16em]"><span>{x["dur"]}</span></div>
                                </div>
                                <p className="mt-3 text-sm text-muted-foreground leading-relaxed">
                                    {x["desc"]}
                                </p>
                                <Link to="/experiences" className="mt-4 inline-flex items-center gap-2 text-sm font-medium" style={{"color": "var(--color-gold)"}}>
                                    Explore
                                    <span className="transition-transform duration-200 group-hover:translate-x-0.5">→</span>
                                </Link>
                            </div>
                        </div>
                        for x in [
                            {
                                "title": "Glacier Express Scenic Journey",
                                "loc": "St. Moritz → Zermatt",
                                "rating": "4.8 / 5",
                                "price": "CHF 189",
                                "dur": "1 day",
                                "desc": "A cinematic ride through alpine passes, deep gorges, and postcard-perfect valleys — reserved seats included.",
                                "img": "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=1600&q=80"
                            },
                            {
                                "title": "Zermatt Matterhorn Guided Tour",
                                "loc": "Zermatt",
                                "rating": "4.9 / 5",
                                "price": "CHF 290",
                                "dur": "8h",
                                "desc": "Meet the Matterhorn up close with a local guide — viewpoints, village stories, and the best photo stops.",
                                "img": "https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=1600&q=80"
                            },
                            {
                                "title": "Interlaken Adventure Pass",
                                "loc": "Interlaken",
                                "rating": "4.7 / 5",
                                "price": "CHF 149",
                                "dur": "Full day",
                                "desc": "Bundle paragliding views, lake time, and mountain fun — flexible scheduling with premium partners.",
                                "img": "https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=1600&q=80"
                            },
                            {
                                "title": "Lucerne Lake Cruise",
                                "loc": "Lucerne",
                                "rating": "4.7 / 5",
                                "price": "CHF 79",
                                "dur": "2.5h",
                                "desc": "Glide across Lake Lucerne at golden hour — panoramic decks, calm coves, and iconic shoreline views.",
                                "img": "https://images.unsplash.com/photo-1500375592092-40eb2168fd21?auto=format&fit=crop&w=1600&q=80"
                            }
                        ]
                    ]}
                </div>
            </section>

            <section className="max-w-6xl mx-auto px-4 pb-12 md:pb-16">
                <div className="se-glass rounded-[var(--radius-xl)] p-6 md:p-8">
                    <div className="flex flex-col md:flex-row md:items-end md:justify-between gap-6">
                        <div>
                            <h2 className="text-2xl md:text-3xl" style={{"fontFamily": "var(--font-display)"}}>Explore by category</h2>
                            <p className="mt-2 text-sm text-muted-foreground max-w-xl">From alpine adventures to lake cruises — find your travel style, then book in minutes.</p>
                        </div>
                        <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Premium curation • Verified hosts</div>
                    </div>
                    <div className="mt-6 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                        {[
                            <CategoryCard key={c["name"]} name={c["name"]} desc={c["desc"]} icon={c["icon"]} />
                            for c in categories
                        ]}
                    </div>
                </div>
            </section>

            <section className="max-w-6xl mx-auto px-4 pb-12 md:pb-16">
                <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
                    <div className="lg:col-span-7 se-glass rounded-[var(--radius-xl)] p-6 md:p-8">
                        <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Why travel with SwissEscape</div>
                        <h2 className="mt-3 text-2xl md:text-3xl" style={{"fontFamily": "var(--font-display)"}}>Premium planning meets local expertise.</h2>
                        <div className="mt-5 grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <div className="rounded-[var(--radius-lg)] border border-border bg-white/55 p-5">
                                <div className="text-sm font-semibold">Curated hosts</div>
                                <div className="mt-1 text-sm text-muted-foreground leading-relaxed">Local guides and vendors vetted for quality, safety, and storytelling.</div>
                            </div>
                            <div className="rounded-[var(--radius-lg)] border border-border bg-white/55 p-5">
                                <div className="text-sm font-semibold">Seamless booking</div>
                                <div className="mt-1 text-sm text-muted-foreground leading-relaxed">One marketplace for experiences, stays, and transport — with premium support.</div>
                            </div>
                            <div className="rounded-[var(--radius-lg)] border border-border bg-white/55 p-5">
                                <div className="text-sm font-semibold">Cinematic routes</div>
                                <div className="mt-1 text-sm text-muted-foreground leading-relaxed">Scenic trains, lake cruises, and alpine viewpoints — optimized day-by-day.</div>
                            </div>
                            <div className="rounded-[var(--radius-lg)] border border-border bg-white/55 p-5">
                                <div className="text-sm font-semibold">Smart itinerary</div>
                                <div className="mt-1 text-sm text-muted-foreground leading-relaxed">AI-assisted planning tailored to your budget, style, and pace.</div>
                            </div>
                        </div>
                    </div>

                    <div className="lg:col-span-5 flex flex-col gap-6">
                        <div className="se-glass rounded-[var(--radius-xl)] p-6 md:p-8">
                            <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Traveler stories</div>
                            <div className="mt-4 flex flex-col gap-4">
                                {[
                                    <TestimonialCard key={t["name"]} quote={t["quote"]} name={t["name"]} meta={t["meta"]} />
                                    for t in testimonials
                                ]}
                            </div>
                        </div>

                        <div className="rounded-[var(--radius-xl)] overflow-hidden border border-border shadow-card">
                            <div className="h-44 bg-cover bg-center" style={{"backgroundImage": "url(https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1600&q=80)"}} />
                            <div className="p-6 bg-white">
                                <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Ready to plan?</div>
                                <div className="mt-2 text-lg font-semibold">Build your Switzerland itinerary in minutes.</div>
                                <div className="mt-4 flex gap-2">
                                    <Link to="/itinerary" className="h-10 px-4 inline-flex items-center justify-center rounded-xl bg-primary text-primary-foreground text-sm font-medium border border-primary hover:opacity-95 transition-opacity">Start itinerary</Link>
                                    <Link to="/experiences" className="h-10 px-4 inline-flex items-center justify-center rounded-xl border border-border bg-white text-sm font-medium hover:bg-muted transition-colors">Browse</Link>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <footer className="border-t border-border bg-white/70">
                <div className="max-w-6xl mx-auto px-4 py-10">
                    <div className="grid grid-cols-1 md:grid-cols-12 gap-8">
                        <div className="md:col-span-5">
                            <div className="text-xl" style={{"fontFamily": "var(--font-display)"}}>SwissEscape</div>
                            <p className="mt-2 text-sm text-muted-foreground max-w-md">
                                A premium marketplace for Swiss experiences, stays, and cinematic journeys — curated by locals.
                            </p>
                            <div className="mt-5 se-glass rounded-[var(--radius-lg)] p-4">
                                <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Newsletter</div>
                                <div className="mt-2 flex gap-2">
                                    <input className="flex-1 h-10 rounded-xl border border-border bg-white/60 px-3 text-sm outline-none" placeholder="Email address" />
                                    <button className="h-10 px-4 rounded-xl bg-primary text-primary-foreground text-sm font-medium border border-primary hover:opacity-95 transition-opacity">Join</button>
                                </div>
                            </div>
                        </div>
                        <div className="md:col-span-7 grid grid-cols-2 sm:grid-cols-3 gap-6">
                            <div>
                                <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Explore</div>
                                <div className="mt-3 flex flex-col gap-2">
                                    <Link to="/destinations" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Destinations</Link>
                                    <Link to="/experiences" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Experiences</Link>
                                    <Link to="/stays" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Stays</Link>
                                </div>
                            </div>
                            <div>
                                <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Company</div>
                                <div className="mt-3 flex flex-col gap-2">
                                    <Link to="/host" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Become a host</Link>
                                    <Link to="/support" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Support</Link>
                                    <Link to="/support" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Contact</Link>
                                </div>
                            </div>
                            <div>
                                <div className="text-xs uppercase tracking-[0.16em] text-muted-foreground">Account</div>
                                <div className="mt-3 flex flex-col gap-2">
                                    <Link to="/login" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Login</Link>
                                    <Link to="/dashboard" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Dashboard</Link>
                                    <Link to="/admin" className="text-sm text-foreground/80 hover:text-foreground transition-colors">Admin</Link>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div className="mt-10 flex flex-col md:flex-row md:items-center md:justify-between gap-3 text-xs text-muted-foreground">
                        <div>© SwissEscape • Switzerland travel marketplace</div>
                        <div className="flex gap-4">
                            <a className="hover:text-foreground transition-colors" href="#">Instagram</a>
                            <a className="hover:text-foreground transition-colors" href="#">YouTube</a>
                            <a className="hover:text-foreground transition-colors" href="#">X</a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    );
}
