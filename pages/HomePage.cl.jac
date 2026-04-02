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
    has group_size: str = "2";
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
            <section className="relative overflow-hidden">
                <div
                    className="absolute inset-0"
                    style={{
                        "backgroundImage": "linear-gradient(180deg, rgba(7,20,39,0.55), rgba(7,20,39,0.15) 55%, rgba(247,250,252,1)), url(" + hero_img + ")",
                        "backgroundSize": "cover",
                        "backgroundPosition": "center"
                    }}
                />
                <div className="relative max-w-6xl mx-auto px-4 pt-16 pb-14 md:pt-24 md:pb-20">
                    <div className="se-fade-in">
                        <div className="inline-flex items-center gap-2 rounded-full border border-white/20 bg-white/10 px-4 py-2 text-xs text-white/90 backdrop-blur">
                            <span className="h-1.5 w-1.5 rounded-full" style={{"backgroundColor": "var(--color-gold)"}} />
                            <span className="tracking-[0.14em] uppercase">SwissEscape • Curated Switzerland</span>
                        </div>
                        <h1 className="mt-6 text-white leading-[1.02] tracking-[-0.02em] text-5xl md:text-7xl" style={{"fontFamily": "var(--font-display)"}}>
                            Discover Switzerland,
                            <span className="block text-white/90">booked like a film.</span>
                        </h1>
                        <p className="mt-5 max-w-2xl text-white/85 text-base md:text-lg leading-relaxed">
                            Premium local experiences, scenic journeys, and luxury stays — curated by Swiss hosts and designed for effortless travel.
                        </p>
                    </div>

                    <div className="mt-10 se-glass rounded-[var(--radius-xl)] p-4 md:p-5 se-fade-in">
                        <form onSubmit={on_submit} className="grid grid-cols-1 md:grid-cols-12 gap-3">
                            <div className="md:col-span-3">
                                <label className="block text-[11px] uppercase tracking-[0.14em] text-muted-foreground mb-2">Destination</label>
                                <input value={destination} onChange={on_destination} placeholder="Zermatt, Lucerne, Interlaken..." className="w-full h-11 rounded-xl border border-border bg-white/60 text-foreground px-3 text-sm outline-none focus:ring-[3px] focus:ring-primary/10" />
                            </div>
                            <div className="md:col-span-3">
                                <label className="block text-[11px] uppercase tracking-[0.14em] text-muted-foreground mb-2">Experience</label>
                                <input value={exp_type} onChange={on_type} placeholder="Train, lake cruise, hiking..." className="w-full h-11 rounded-xl border border-border bg-white/60 text-foreground px-3 text-sm outline-none focus:ring-[3px] focus:ring-primary/10" />
                            </div>
                            <div className="md:col-span-2">
                                <label className="block text-[11px] uppercase tracking-[0.14em] text-muted-foreground mb-2">Dates</label>
                                <input value={dates} onChange={on_dates} placeholder="Jun 12–16" className="w-full h-11 rounded-xl border border-border bg-white/60 text-foreground px-3 text-sm outline-none focus:ring-[3px] focus:ring-primary/10" />
                            </div>
                            <div className="md:col-span-2">
                                <label className="block text-[11px] uppercase tracking-[0.14em] text-muted-foreground mb-2">Group</label>
                                <input value={group_size} onChange={on_group} placeholder="2" className="w-full h-11 rounded-xl border border-border bg-white/60 text-foreground px-3 text-sm outline-none focus:ring-[3px] focus:ring-primary/10" />
                            </div>
                            <div className="md:col-span-2">
                                <label className="block text-[11px] uppercase tracking-[0.14em] text-muted-foreground mb-2">Budget</label>
                                <input value={budget} onChange={on_budget} placeholder="CHF 500–1500" className="w-full h-11 rounded-xl border border-border bg-white/60 text-foreground px-3 text-sm outline-none focus:ring-[3px] focus:ring-primary/10" />
                            </div>
                            <div className="md:col-span-12 flex flex-col md:flex-row gap-3 md:items-center md:justify-between pt-1">
                                <div className="text-xs text-muted-foreground">
                                    Try: <span className="text-foreground/80">Glacier Express</span> or <span className="text-foreground/80">Lake cruise</span>
                                </div>
                                <button type="submit" className="h-11 px-5 rounded-xl bg-primary text-primary-foreground text-sm font-medium border border-primary hover:opacity-95 transition-opacity">
                                    Search experiences
                                </button>
                            </div>
                        </form>
                    </div>

                    <div className="mt-10 flex flex-wrap gap-3 se-fade-in">
                        <Link to="/itinerary" className="inline-flex items-center gap-2 rounded-full px-4 py-2 text-sm border border-white/20 bg-white/10 text-white/90 backdrop-blur hover:bg-white/15 transition-colors">
                            Build AI itinerary
                            <span className="text-[12px]" style={{"color": "var(--color-gold)"}}>•</span>
                            <span className="text-white/80">Premium planning</span>
                        </Link>
                        <Link to="/host" className="inline-flex items-center gap-2 rounded-full px-4 py-2 text-sm border border-white/20 bg-white/10 text-white/90 backdrop-blur hover:bg-white/15 transition-colors">
                            Become a local host
                            <span className="text-white/70">Earn with your expertise</span>
                        </Link>
                    </div>
                </div>
            </section>

            <section className="max-w-6xl mx-auto px-4 py-12 md:py-16">
                <div className="flex items-end justify-between gap-6">
                    <div>
                        <h2 className="text-2xl md:text-3xl" style={{"fontFamily": "var(--font-display)"}}>Featured destinations</h2>
                        <p className="mt-2 text-sm text-muted-foreground max-w-xl">Iconic Swiss places — curated for cinematic views, effortless logistics, and premium stays.</p>
                    </div>
                    <Link to="/destinations" className="hidden md:inline-flex items-center gap-2 text-sm font-medium text-primary hover:opacity-80 transition-opacity">
                        Explore all
                        <span aria-hidden="true">→</span>
                    </Link>
                </div>

                <div className="mt-7 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
                    {[
                        <DestCard key={d["name"]} name={d["name"]} tag={d["tag"]} img={d["img"]} to="/destinations" />
                        for d in featured_destinations
                    ]}
                </div>
            </section>

            <section className="max-w-6xl mx-auto px-4 pb-12 md:pb-16">
                <div className="flex items-end justify-between gap-6">
                    <div>
                        <h2 className="text-2xl md:text-3xl" style={{"fontFamily": "var(--font-display)"}}>Popular Swiss experiences</h2>
                        <p className="mt-2 text-sm text-muted-foreground max-w-xl">Handpicked tours and journeys with premium hosts, verified reviews, and seamless booking.</p>
                    </div>
                    <Link to="/experiences" className="hidden md:inline-flex items-center gap-2 text-sm font-medium text-primary hover:opacity-80 transition-opacity">
                        Browse marketplace
                        <span aria-hidden="true">→</span>
                    </Link>
                </div>

                <div className="mt-7 grid grid-cols-1 md:grid-cols-2 gap-5">
                    {[
                        <ExperienceCard
                            key={x["title"]}
                            title={x["title"]}
                            loc={x["loc"]}
                            dur={x["dur"]}
                            price={x["price"]}
                            rating={x["rating"]}
                            reviews={x["reviews"]}
                            img={x["img"]}
                            cat={x["cat"]}
                        />
                        for x in popular
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
